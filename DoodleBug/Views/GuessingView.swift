//
//  GuessingView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI

struct GuessingView: View {
    @EnvironmentObject var gameManager: GameStateManager
    
    // State for the guessing timer
    @State private var timeRemaining = 10
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Guess Now!")
                .font(.largeTitle).bold()
            
            Text("Time: \(timeRemaining)")
                .font(.title2).bold().foregroundColor(.red)
            
            // Display the final drawing, but disable it so no one can edit it.
            DrawingCanvasView(drawing: $gameManager.currentDrawing, selectedColor: .black)
                .border(Color.gray, width: 1)
                .disabled(true) // <<< IMPORTANT
            
            Spacer()
            
            Button("Correctly Guessed!") {
                // TODO: Add points in the future!
                timer.upstream.connect().cancel() // Stop our timer
                gameManager.finishTurn() // End the turn
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .font(.title2)
            
            Spacer()
        }
        .padding()
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.upstream.connect().cancel()
                gameManager.finishTurn() // End turn when time is up
            }
        }
    }
}