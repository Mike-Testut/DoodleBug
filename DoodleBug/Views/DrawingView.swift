//
//  DrawingView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI
import PencilKit
import Combine

struct DrawingView: View {
    @EnvironmentObject var gameManager: GameStateManager
    
    // All the state for the drawing screen now lives here
    @State private var canvasView = PKCanvasView()
    @State private var timeRemaining = 25
//    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timerSubscription: AnyCancellable?
    
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
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
    func startTimer() {
            self.timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect().sink { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    } else {
                        self.stopTimer()
                        self.gameManager.startGuessingTime()
                    }
                }
        }
        
    func stopTimer() {
        timerSubscription?.cancel()
    }
}
