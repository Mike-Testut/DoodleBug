//
//  ScoreboardView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/28/25.
//


import SwiftUI

struct ScoreboardView: View {
    @EnvironmentObject var gameManager: GameStateManager
    
    // We need access to the root navigation state from HomeView
    // to dismiss the entire game and go back to the setup screen.
    @Binding var isGameActive: Bool
    
    // A computed property to sort players by score, descending
    var rankedPlayers: [Player] {
        gameManager.players.sorted { $0.score > $1.score }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Game Over!")
                .font(.system(size: 50, weight: .bold, design: .rounded))
            
            Text("Final Scores")
                .font(.title2).foregroundColor(.secondary)
            
            // List of players ranked by score
            List(rankedPlayers) { player in
                HStack {
                    Text(player.name)
                        .font(.headline)
                    Spacer()
                    Text("\(player.score) pts")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            .cornerRadius(10)
            .listStyle(.plain)
            
            Spacer()
            
            // Action buttons
            VStack(spacing: 15) {
                Button("Play Again With Same Players") {
                    // Reset scores and start a new game
                    gameManager.resetScoresAndStartGame()
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(.green)
                
                Button("New Game (Change Players)") {
                    // This dismisses the game session and returns to HomeView
                    isGameActive = false
                }
                .font(.title2)
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}