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
    private var possibleImageTitles = ["BillboardFOUT-1", "BillboardGOED-1", "GebouwFOUT-1", "GebouwGOED-1", "Gloei(LED)lampGOED-1", "GloeilampFOUT-1", "HuisLampenFOUT-1", "HuisLampenGOED-1", "KassenFOUT-1", "KassenGOED-1", "LantaarnpaalFOUT-1", "LantaarnpaalGOED-1", "LantaarnpaalrijFOUT-1", "LantaarnpaalrijGOED-1", "SensorFOUT-1", "SensorGOED-1", "winkelFOUT-1", "winkelGOED-1", "xPlaceholder1FOUT-1", "xPlaceholder1GOED-1"] //20 verschillende afbeeldingen
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
