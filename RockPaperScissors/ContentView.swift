//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by slava bily on 2/3/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    
    @State private var questionNumber = 1
    @State private var appCurrentChoise = Int.random(in: 0..<3)
    @State private var shouldPlayerWin = Bool.random()
    @State private var score = 0
    @State private var showingAlert = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Score: \(score)")
                    .font(.headline)
                
                Spacer()
                
                Text(possibleMoves[appCurrentChoise])
                
                Text(shouldPlayerWin ? "Win" : "Loose")
                
                Spacer()
                
                HStack(spacing: 30) {
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.buttonTapped(number)
                        }) {
                            Text(self.possibleMoves[number])
                        }
                    }
                }
            }
            .navigationBarTitle("Rock Paper Scissors")
            .font(.largeTitle)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Game over"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue"), action: {
                    self.score = 0
                    self.questionNumber = 1
                    self.askQuestion()
                }))
            }
        }
        
    }
    
    func buttonTapped(_ number: Int) {
        
        while questionNumber < 10 {
            logic(number)
            questionNumber += 1
            askQuestion()
            return
        }
        logic(number)
        showingAlert = true
    }
    
    func logic(_ number: Int) {
        if appCurrentChoise < 2 {
            if shouldPlayerWin {
                if number == appCurrentChoise + 1 {
                    score += 1
                } else {
                    score -= 1
                }
            } else {
                if number == appCurrentChoise + 1 {
                    score -= 1
                } else {
                    score += 1
                }
            }
        } else {
            if shouldPlayerWin {
                if number == appCurrentChoise - 2 {
                    score += 1
                } else {
                    score -= 1
                }
            } else {
                if number == appCurrentChoise - 2 {
                    score -= 1
                } else {
                    score += 1
                }
            }
        }
    }
    
    func askQuestion() {
        appCurrentChoise = Int.random(in: 0..<3)
        shouldPlayerWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
