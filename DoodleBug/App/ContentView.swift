//
//  ContentView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/25/25.
//

import SwiftUI

// This blueprint struct is still very useful!
struct Challenge: Identifiable {
    let id = UUID()
    let word: String
    let constraint: String
}

struct ContentView: View {
    
    // Our state variable that holds the one, currently active challenge.
    @State private var currentChallenge: Challenge
    
    // The initializer sets up the view's first state.
    init() {
        // 1. Generate the random word and constraint first.
        let firstWord = GameData.words.randomElement() ?? "Apple"
        let firstConstraint = GameData.constraints.randomElement() ?? "normally."
        
        // 2. Create the initial Challenge object.
        let initialChallenge = Challenge(word: firstWord, constraint: firstConstraint)
        
        // 3. NOW, initialize the state variable with our fully formed object.
        _currentChallenge = State(initialValue: initialChallenge)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("DoodleBug")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack {
                Text("Draw This:")
                    .font(.caption)
                    .foregroundColor(.gray)
                // This Text now reads from our @State variable
                Text(currentChallenge.word)
                    .font(.title2)
                    .fontWeight(.medium)
            }
            
            VStack {
                Text("Constraint:")
                    .font(.caption)
                    .foregroundColor(.gray)
                // This Text also reads from our @State variable
                Text(currentChallenge.constraint)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.red)
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
            
            Button("New Challenge") {
                // The button's action now calls our generator function.
                self.currentChallenge = generateNewChallenge()
            }
            .font(.title)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

        }
        .padding()
    }
    
    // This private function is our challenge factory. It mixes and matches!
    private func generateNewChallenge() -> Challenge {
        let randomWord = GameData.words.randomElement() ?? "Apple"
        let randomConstraint = GameData.constraints.randomElement() ?? "normally."
        
        return Challenge(word: randomWord, constraint: randomConstraint)
    }
}

#Preview {
    ContentView()
}
