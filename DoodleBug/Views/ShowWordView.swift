//
//  ShowWordView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI
import Combine

struct ShowWordView: View {
    @EnvironmentObject var gameManager: GameStateManager
    // Timer specific to this view
    @State private var timeRemaining = 5
    @State private var timerSubscription: AnyCancellable?
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Get ready! \(timeRemaining)")
                .font(.largeTitle)
                .onAppear(perform: startTimer)
                .onDisappear(perform: stopTimer)
            Spacer()
            
            if let challenge = gameManager.currentChallenge {
                Text("Draw This:")
                    .font(.caption)
                Text(challenge.word)
                    .font(.system(size: 40, weight: .bold))
                
                Text("Constraint:")
                    .font(.caption)
                    .padding(.top)
                Text(challenge.constraint)
                    .font(.title)
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            Button("Got It! Start Drawing") {
                // Let the user start early if they want
                gameManager.startDrawing()
            }
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
    }
    
    func startTimer() {
          // Create the timer publisher
          let timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
          
          // Use .sink to handle the timer's output and store the subscription
          self.timerSubscription = timerPublisher.autoconnect().sink { _ in
              // This is the code that runs every second
              if self.timeRemaining > 0 {
                  self.timeRemaining -= 1
              } else {
                  // When time is up, stop the timer and change the phase
                  self.stopTimer()
                  self.gameManager.startDrawing()
              }
          }
      }
      
      // 5. A function to stop the timer
      func stopTimer() {
          // Cancel the subscription to stop the timer
          timerSubscription?.cancel()
      }
  
}
