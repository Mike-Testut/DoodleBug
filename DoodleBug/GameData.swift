//
//  GameData.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//

import Foundation

struct Challenge: Identifiable {
    let id = UUID()
    let word: String
    let constraint: String
}

// We'll create a struct to act as a namespace for our game's data.
// This is cleaner than having global variables.
struct GameData {
    
    // The 'static' keyword means we can access this data without
    // creating an instance of GameData. We can just write 'GameData.words'.
    
    static let words: [String] = [
        "Mona Lisa",
        "A rollercoaster",
        "A dog",
        "A car",
        "A houseplant",
        "The Eiffel Tower",
        "A birthday cake",
        "A submarine",
        "A robot",
        "A dragon",
        "A superhero",
        "A pirate ship"
    ]
    
    static let constraints: [String] = [
        "using only straight lines.",
        "with your eyes closed.",
        "without lifting your finger.",
        "using your non-dominant hand.",
        "using only 5 lines.",
        "drawing with your pinky finger.",
        "while humming a song.",
        "using only circles and squares.",
        "in under 10 seconds."
    ]
}
