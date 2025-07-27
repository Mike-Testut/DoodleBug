//
//  GetReadyView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI

struct GetReadyView: View {
    @EnvironmentObject var gameManager: GameStateManager
    
    var body: some View {
        VStack(spacing: 20) {
            if let drawer = gameManager.currentDrawer {
                Text("Next up...")
                    .font(.title2)
                
                Text(drawer.name)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                
                Text("You're drawing!")
                    .font(.title)
            }
            
            Spacer()
            
            Text("You will have 5 seconds to see the word and constraint.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("I'm Ready!") {
                // Call the game manager to advance to the next phase
                gameManager.prepareNewChallenge()
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            
            Spacer()
        }
        .padding()
    }
}