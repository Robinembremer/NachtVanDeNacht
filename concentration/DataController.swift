//
//  DataController.swift
//  concentration
//
//  Created by Ricardo van Burik on 07/11/2018.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import Foundation
import UIKit

struct DataController{
    
    private var cards = [Card]()
    private var possibleImageTitles = ["icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple", "icon-apple"] //20 verschillende afbeeldingen
    var possibleIdentifiers = [[1,2], [2,2], [3,2], [4,2], [5,2], [6,2], [7,2], [8,2], [9,2], [10,2]]
    
    private mutating func createPossibleCards(){
        for _ in possibleImageTitles {
            if let id = self.getRandomIdentifier(), let image = self.getImage() {
                cards.append(Card(identifier: id, image: image))
            }
        }
    }
    
//    For testing purposes
    mutating func getRandomIdentifier() -> Int? {
        self.possibleIdentifiers.shuffle()
        for var identifier in self.possibleIdentifiers {
            if identifier[1] > 0 {
                identifier[1] -= 1
                return identifier[0]
            }
        }
        return nil
    }
    
    mutating func getImage() -> UIImage? {
        for (index, title) in possibleImageTitles.enumerated() {
            let image = UIImage(named: title)
            possibleImageTitles.remove(at: index)
            return image
        }
        return nil
    }
    
}
