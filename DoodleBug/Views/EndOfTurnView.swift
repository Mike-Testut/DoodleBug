//
//  EndOfTurnView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI

struct EndOfTurnView: View {
    @EnvironmentObject var gameManager: GameStateManager

    var body: some View {
        VStack(spacing: 30) {
            Text("Time's Up!")
                .font(.largeTitle).bold()
            
            if let challenge = gameManager.currentChallenge {
                Text("The word was:")
                    .font(.headline)
                
                Text(challenge.word)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.green)
            }
            
            Button("Next Turn") {
                gameManager.nextTurn()
            }
            .buttonStyle(.borderedProminent)
            .font(.title)
            
            Button("End Game & View Scores") {
                gameManager.endGame()
            }
            .tint(.red)
            .padding(.top)
        }
    }
}
