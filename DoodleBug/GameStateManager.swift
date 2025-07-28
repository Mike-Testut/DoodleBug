//
//  GameStateManager.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//




import Foundation
import SwiftUI
import PencilKit

enum TurnPhase {
    case getReady   // Screen telling the next drawer to get ready
    case showWord   // Screen showing the word ONLY to the drawer
    case drawing    // The main drawing screen
    case guessing  // Player guessing screen
    case selectGuesser
    case endOfTurn  // Screen showing the word after the turn is over
    case gameOver //scoreboard
}

struct Player: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var score: Int = 0
}


class GameStateManager: ObservableObject {
    

    @Published var players: [Player] = []
    @Published var currentPlayer: Player?
    @Published var currentDrawer: Player?
    @Published var currentPhase: TurnPhase = .getReady
    @Published var currentChallenge: Challenge?
    @Published var currentDrawing = PKDrawing()
    
    // Game Setup
    func addPlayer(name: String) {
        // Don't add empty names
        if !name.trimmingCharacters(in: .whitespaces).isEmpty {
            let newPlayer = Player(name: name)
            players.append(newPlayer)
        }
    }
    
    // Game Flow
    func startGame() {
        guard !players.isEmpty else {
            print("Cannot start game without players!")
            return
        }
        // When the game starts, pick a random player to draw first.
        currentDrawer = players.randomElement()
    }
    
    func nextTurn() {
       
        let otherPlayers = players.filter { $0.id != currentDrawer?.id }

        if !otherPlayers.isEmpty {
            currentDrawer = otherPlayers.randomElement()
        } else {
            currentDrawer = players.randomElement()
        }
        currentDrawing = PKDrawing()
        currentPhase = .getReady
        
        currentPlayer = currentDrawer
    }
    
    func prepareNewChallenge() {
           let randomWord = GameData.words.randomElement() ?? "Default Word"
           let randomConstraint = GameData.constraints.randomElement() ?? "Default Constraint"
           currentChallenge = Challenge(word: randomWord, constraint: randomConstraint)
           
           // Move to the next phase
           currentPhase = .showWord
       }
    
    func startDrawing() {
          currentPhase = .drawing
      }
    
    func startGuessingTime() {
            currentPhase = .guessing
        }
      
    func promptForGuesser() {
        currentPhase = .selectGuesser
    }

    // This is called when a guesser is chosen from the new screen.
    func awardPoints(to guesser: Player) {
        // Award 2 points to the guesser
        if let guesserIndex = players.firstIndex(where: { $0.id == guesser.id }) {
            players[guesserIndex].score += 2
        }
        
        // Award 1 point to the drawer for a successful drawing
        if let drawerIndex = players.firstIndex(where: { $0.id == currentDrawer?.id }) {
            players[drawerIndex].score += 1
        }
        
        // After awarding points, the turn is over.
        finishTurn()
    }
    
    func finishTurn() {
      currentPhase = .endOfTurn
    }
    
    func endGame() {
            currentPhase = .gameOver
        }
        
    func resetScoresAndStartGame() {
        // Reset the score for every player
        for i in 0..<players.count {
            players[i].score = 0
        }
        
        startGame()
    }
}
