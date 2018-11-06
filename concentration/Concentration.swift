//
//  Concentration.swift
//  concentration
//
//  Created by Ricardo van Burik on 05-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    var gameTheme = ThemeFactory.allThemes[0].theme
    var pointsInGame = 0
    var flipsInGame = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    init(numberOfPairsOfCard: Int, gameTheme: Theme){
        startNewGame(numberOfPairsOfCard: numberOfPairsOfCard, theme: gameTheme)
    }
    
    init(numberOfPairsOfCard: Int){
        startNewGameWithRandomTheme(numberOfPairsOfCard: numberOfPairsOfCard)
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at index: \(index)): Chosen index not in the cards")
        cards[index].nTimesTouched += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].hasAMatch()
                    cards[index].hasAMatch()
                    let addedPoints = self.calculatePointsAfterTwoMatchedCards(with: cards[matchIndex], and: cards[index])
                    self.pointsInGame = self.pointsInGame + addedPoints
                }
                cards[index].isFaceUp = true
            }
            else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func startNewGameWithRandomTheme(numberOfPairsOfCard: Int){
        chooseRandomThemeForGame()
        startNewGame(numberOfPairsOfCard: numberOfPairsOfCard, theme: self.gameTheme)
    }
    
    mutating func startNewGame(numberOfPairsOfCard: Int, theme: Theme){
        assert(numberOfPairsOfCard > 0, "Concentration.startNewGame(numberOfParsOfCard \(numberOfPairsOfCard): You must have at least one pair of cards.")
        self.pointsInGame = 0
        self.gameTheme = theme
        
        cards.removeAll()
        for _ in 0..<numberOfPairsOfCard {
            let card = Card()
            cards += [card, card] 
        }
        cards.shuffle()
    }
    
    mutating private func chooseRandomThemeForGame(){
        self.gameTheme = ThemeFactory.randomTheme.theme
        print("Game theme set to \(self.gameTheme)")
    }
    
    
    func calculatePointsAfterTwoMatchedCards(with firstCard: Card, and secondCard: Card)->Int {
        if firstCard.nTimesTouched > 3 || secondCard.nTimesTouched > 3 {
            return -2
        }
        else if firstCard.nTimesTouched > 2 || secondCard.nTimesTouched > 2 {
            return -1
        }
        return 2
    }
    
     mutating func addFlipToGameAndReturn() -> Int{
        flipsInGame += 1
        return self.flipsInGame
    }

}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
