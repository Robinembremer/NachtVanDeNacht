//
//  PlayingCard.swift
//  concentration
//
//  Created by Ricardo van Burik on 06/11/2018.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import UIKit

class PlayingCard: UIButton {
    
    var card: Card!
    
    func setupPlayingCard(card: Card){
        self.card = card
    }
    
    override func draw(_ rect: CGRect) {
        self.setTitle("", for: .normal)
        let roundedRect = UIBezierPath(rect: rect)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        self.card.image.draw(in: bounds)

        
    }
}
