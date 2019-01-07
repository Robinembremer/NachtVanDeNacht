//
//  Concentration.swift
//  concentration
//
//  Created by Ricardo van Burik on 05-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import UIKit

struct Concentration {
    
    private(set) var cards = [Card]()
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
    init(numberOfPairsOfCard: Int){
        startNewGame(numberOfPairsOfCard: numberOfPairsOfCard)
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
    
    mutating func startNewGame(numberOfPairsOfCard: Int){
        assert(numberOfPairsOfCard > 0, "Concentration.startNewGame(numberOfParsOfCard \(numberOfPairsOfCard): You must have at least one pair of cards.")
        self.pointsInGame = 0
        
        cards.removeAll()
        for index in 0..<numberOfPairsOfCard {
            let card = Card(identifier: 1, image: UIImage(named: "icon-apple")!)
            cards += [card, card]
            print(index)
        }
        cards.shuffle()
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
