//
//  GuessingView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI
import Combine

struct GuessingView: View {
    @EnvironmentObject var gameManager: GameStateManager
    
    // State for the guessing timer
    @State private var timeRemaining = 10
//    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timerSubscription: AnyCancellable?
    
    var body: some View {
        VStack {
            Text("Guess Now!")
                .font(.largeTitle).bold()
            
            Text("Time: \(timeRemaining)")
                .font(.title2).bold().foregroundColor(.red)
            
            // Display the final drawing, but disable it so no one can edit it.
            DrawingCanvasView(drawing: $gameManager.currentDrawing, selectedColor: .black)
                .border(Color.gray, width: 1)
                .disabled(true) // <<< IMPORTANT
            
            Spacer()
            
            Button("Correctly Guessed!") {
                // TODO: Add points in the future!
                self.stopTimer() // Stop our timer
                gameManager.promptForGuesser()
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .font(.title2)
            
            Spacer()
        }
        .padding()
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
    func startTimer() {
        self.timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect().sink { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stopTimer()
                    self.gameManager.finishTurn()
                }
            }
    }
    
    func stopTimer() {
        timerSubscription?.cancel()
    }
}
