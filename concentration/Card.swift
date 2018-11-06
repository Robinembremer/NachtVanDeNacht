//
//  Card.swift
//  concentration
//
//  Created by Ricardo van Burik on 05-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import Foundation

struct Card: Hashable {

    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    var nTimesTouched = 0
    
    private static var identifierFactory = 0
    
    private static func getUniqueIndentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIndentifier()
    }
    
    mutating func hasAMatch(){
        self.isMatched = true
    }
    
    
}

