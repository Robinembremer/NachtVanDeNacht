//
//  DataController.swift
//  concentration
//
//  Created by Ricardo van Burik on 09/01/2019.
//  Copyright © 2019 Ricardo van Burik. All rights reserved.
//

import UIKit

class DataController{
    
    var imageURLs = [["BillboardFOUT-1", "BillboardGOED-1"], ["GebouwFOUT-1", "GebouwGOED-1"], ["Gloei(LED)lampGOED-1", "GloeilampFOUT-1"], ["HuisLampenFOUT-1", "HuisLampenGOED-1"], ["KassenFOUT-1", "KassenGOED-1"], ["LantaarnpaalFOUT-1", "LantaarnpaalGOED-1"], ["LantaarnpaalrijFOUT-1", "LantaarnpaalrijGOED-1"], ["SensorFOUT-1", "SensorGOED-1"], ["winkelFOUT-1", "winkelGOED-1"], ["xPlaceholder1FOUT-1", "xPlaceholder1GOED-1"]]
    
    var testURLS = ["BillboardFOUT-1", "BillboardGOED-1", "GebouwFOUT-1", "GebouwGOED-1", "Gloei(LED)lampGOED-1", "GloeilampFOUT-1", "HuisLampenFOUT-1", "HuisLampenGOED-1", "KassenFOUT-1", "KassenGOED-1", "LantaarnpaalFOUT-1", "LantaarnpaalGOED-1", "LantaarnpaalrijFOUT-1", "LantaarnpaalrijGOED-1", "SensorFOUT-1", "SensorGOED-1", "winkelFOUT-1", "winkelGOED-1", "xPlaceholder1FOUT-1", "xPlaceholder1GOED-1"]
    
    
    func getImagesAt(index: Int) -> [UIImage]{
        let images = imageURLs[index]
        return [UIImage(named: images[0])!, UIImage(named: images[1])!]
    }
    
    func getRandomImageURLPair() -> [String] {
        let randomInt = self.imageURLs.count.arch4random
        return imageURLs.remove(at: randomInt)
    }
    
}
