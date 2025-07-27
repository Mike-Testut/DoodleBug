//
//  ShowWordView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI

struct ShowWordView: View {
    @EnvironmentObject var gameManager: GameStateManager
    // Timer specific to this view
    @State private var timeRemaining = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Get ready! \(timeRemaining)")
                .font(.largeTitle)
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        gameManager.startDrawing()
                    }
                }
            
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
        .onDisappear {
            // Stop the timer if the view disappears for any reason
            timer.upstream.connect().cancel()
        }
    }
}
