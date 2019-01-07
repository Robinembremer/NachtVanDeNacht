//
//  Card.swift
//  concentration
//
//  Created by Ricardo van Burik on 05-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import UIKit

struct Card: Hashable {
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    var nTimesTouched = 0
    var image: UIImage

    private static var identifierFactory = 0
    
    init(identifier: Int, image: UIImage){
        self.identifier = identifier
        self.image = image
    }
    
    mutating func hasAMatch(){
        self.isMatched = true
    }
    
}

