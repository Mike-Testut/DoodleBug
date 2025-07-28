//
//  HomeView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI

struct HomeView: View {
    // @StateObject will create and keep alive ONE instance of our game manager
    // for the entire lifecycle of this view.
    @StateObject private var gameManager = GameStateManager()
    
    // A state variable for the text field
    @State private var newPlayerName: String = ""
    
    // A state variable to control navigation to the game screen
    @State private var isGameActive = false
    
    var body: some View {
        // NavigationStack is the modern way to handle screen-to-screen navigation.
        NavigationStack {
            VStack {
                Text("DoodleBug")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .padding()
                
                // List of current players
                List {
                    ForEach(gameManager.players) { player in
                        Text(player.name)
                            .font(.headline)
                    }
                }
                .cornerRadius(10)
                
                // Form to add a new player
                HStack {
                    TextField("Enter Player Name", text: $newPlayerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                    
                    Button("Add") {
                        gameManager.addPlayer(name: newPlayerName)
                        newPlayerName = "" // Clear the text field
                    }
                    .padding(.trailing)
                }
                .padding(.bottom)
                
                // Start Game Button
                Button("Start Game!") {
                    gameManager.startGame()
                    isGameActive = true // This will trigger the navigation
                }
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .background(gameManager.players.count > 1 ? Color.green : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                // The button is disabled if there aren't at least 2 players
                .disabled(gameManager.players.count < 2)
                
            }
            .padding()
            // This is the link to the next screen.
            // It activates when $isGameActive becomes true.
            .navigationDestination(isPresented: $isGameActive) {
                // Pass our existing gameManager to the next screen
                ContentView(isGameActive: $isGameActive)
                        .environmentObject(gameManager)
                        // Hide the default back button to enforce our game flow
                        .navigationBarBackButtonHidden(true) 
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
