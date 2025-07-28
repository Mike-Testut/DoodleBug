//
//  ContentView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @EnvironmentObject var gameManager: GameStateManager
    @Binding var isGameActive: Bool
    
    var body: some View {
        // We will build the new logic here
        VStack {
            switch gameManager.currentPhase {
                case .getReady:
                    GetReadyView()
                case .showWord:
                    ShowWordView()
                case .drawing:
                    DrawingView()
                case .guessing:       
                     GuessingView()
                case .selectGuesser: 
                    SelectGuesserView()
                case .endOfTurn:
                    EndOfTurnView()
                case .gameOver:
                    ScoreboardView(isGameActive: $isGameActive)
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
    }
}

// All the helper functions like generateNewChallenge are no longer needed here.
// You can delete them.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isGameActive: .constant(true))
            .environmentObject(GameStateManager())
    }
}
