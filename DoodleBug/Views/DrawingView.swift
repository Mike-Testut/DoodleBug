//
//  DrawingView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI
import PencilKit

struct DrawingView: View {
    @EnvironmentObject var gameManager: GameStateManager
    
    // All the state for the drawing screen now lives here
    @State private var canvasView = PKCanvasView()
    @State private var timeRemaining = 25
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // We'll keep the color palette simple for now
    let availableColors: [Color] = [.black, .red, .blue, .green]
    @State private var selectedColor: Color = .black
    
    var body: some View {
        VStack {
            // Top Bar
            HStack {
                Text("Time: \(timeRemaining)")
                    .font(.title2).bold()
                Spacer()
                // Show the constraint, but NOT the word
                if let constraint = gameManager.currentChallenge?.constraint {
                    Text(constraint)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            .padding()
            
            // The Canvas
            DrawingCanvasView(drawing: $gameManager.currentDrawing, selectedColor: selectedColor)
                            .border(Color.gray, width: 1)
            
            // The Color Palette
            HStack {
                ForEach(availableColors, id: \.self) { color in
                    Circle().fill(color).frame(width: 30, height: 30)
                        .onTapGesture { selectedColor = color }
                        .overlay(Circle().stroke(Color.gray, lineWidth: selectedColor == color ? 2:0))
                }
            }
            .padding()
            
        }
        .padding()
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.upstream.connect().cancel()
                gameManager.startGuessingTime()
            }
        }
        .onAppear {
            // Reset the canvas when the view appears
            canvasView.drawing = PKDrawing()
        }
    }
}
