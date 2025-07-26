//
//  ContentView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/25/25.
//

import SwiftUI
import PencilKit

// This blueprint struct is still very useful!
struct Challenge: Identifiable {
    let id = UUID()
    let word: String
    let constraint: String
}

struct ContentView: View {
    
    @State private var currentChallenge: Challenge
    @State private var canvasView = PKCanvasView()
    @State private var timeRemaining = 45
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isTimeUp = false
    
   
    
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
            Text("Time: \(timeRemaining)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            ZStack {
                // The canvas is the bottom layer
                DrawingCanvasView(canvas: $canvasView)
                    .border(Color.gray, width: 1)
                    .disabled(isTimeUp) // The disabled modifier is still here!

                // We only show this text IF isTimeUp is true
                if isTimeUp {
                    Text("Time's Up!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.75)) // Semi-transparent black background
                        .cornerRadius(15)
                }
            }
            .padding()
            
            HStack(spacing: 20) {
                Button("Clear") {
                    // This action clears the drawing inside our canvas object.
                    canvasView.drawing = PKDrawing()
                }
                .font(.title2)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("New Challenge") {
                    self.currentChallenge = generateNewChallenge()
                    // Also clear the canvas for the new challenge
                    canvasView.drawing = PKDrawing()
                    self.timeRemaining = 45
                    self.isTimeUp = false
                    self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                }
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

        }
        .onReceive(timer){_ in 
            if timeRemaining > 0 {
                // If so, decrease the time by 1.
                timeRemaining -= 1
            } else {
                // If time runs out, stop the timer to save battery.
                // We'll add more "game over" logic here later.
                self.isTimeUp = true
                timer.upstream.connect().cancel()
            }
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
