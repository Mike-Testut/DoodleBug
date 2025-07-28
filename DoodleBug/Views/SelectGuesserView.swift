//
//  SelectGuesserView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/28/25.
//


import SwiftUI

struct SelectGuesserView: View {
    @EnvironmentObject var gameManager: GameStateManager
    
    // A computed property to get a list of players who are NOT the drawer
    var availableGuessers: [Player] {
        gameManager.players.filter { $0.id != gameManager.currentDrawer?.id }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Who Guessed It?")
                .font(.largeTitle).bold()
            
            Text("Select the player who guessed the word correctly.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            // Create a button for each available guesser
            ForEach(availableGuessers) { player in
                Button(player.name) {
                    // When tapped, award points to this player
                    gameManager.awardPoints(to: player)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
            }
            
            Spacer()
            
            // A button for the case where nobody guessed in time
            Button("No One Guessed It") {
                // This just ends the turn without awarding points
                gameManager.finishTurn()
            }
            .tint(.red)
        }
        .padding()
    }
}