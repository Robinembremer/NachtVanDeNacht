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
        showSideOfCard()

    }

    func showSideOfCard(){
        if !self.card.isFaceUp {
            self.imageView?.isHidden = true
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        else {
            self.imageView?.isHidden = false
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.card.image.draw(in: bounds)

        }
    }
    
    func isMatched(){
        self.imageView?.isHidden = true
        self.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    }
}
