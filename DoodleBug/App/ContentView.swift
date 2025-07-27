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
                case .endOfTurn:
                    EndOfTurnView()
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
        let manager = GameStateManager()
        // You might need to set up some dummy data for the preview to work well
        manager.addPlayer(name: "Player 1")
        manager.startGame()
        return ContentView().environmentObject(manager)
    }
}
