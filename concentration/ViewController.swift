//
//  ViewController.swift
//  concentration
//
//  Created by Ricardo van Burik on 05-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private(set) var scoreCount = 0 {
        didSet{
            scoreLabel.text = "Score: \(scoreCount)"
        }
    }
    
    private var record = 0 {
        didSet {
            recordLabel.text = "Highscore: \(record)"
        }
    }
    
    private var emoji = [Card:String]()
    
    var numberOfPairsOfCard: Int {
        if let numberOfCards = cardButtons?.count {
            return (numberOfCards + 1) / 2
        }
        return 10
    }
    
    lazy var game = Concentration(numberOfPairsOfCard: numberOfPairsOfCard)
    
    
    //OUTLETS
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    @IBOutlet private weak var recordLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!

    @IBOutlet private var cardButtons: [UIButton]!
    
    private lazy var emojiChoices = game.gameTheme.icons
    
    override func viewDidLoad() {
        updateViewFromModel()
        setColorsForAllViewRelatedProperties()
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated:true)
    }
    
    @IBAction func touchCard(_ sender: UIButton){
        if let cardNumber = cardButtons.index(of: sender){
            
            self.flipCountLabel.text = "Flipcount: " + String(game.addFlipToGameAndReturn())
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardbuttons")
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton){
        flipCountLabel.text = "Flipcount: 0"
        scoreCount = 0
        setColorsForAllViewRelatedProperties()
        resetAllButtons()
        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isMatched, button.isEnabled {
                button.isEnabled = false;
            }
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : game.gameTheme.colors[1]
            }
        }
        scoreCount = game.pointsInGame
        if !checkIfAnyCardsAreLeft() {
            if checkIfHighscoreIsBeaten(withScore: game.flipsInGame) {
                    record = (game.flipsInGame / 2) + scoreCount
            }
        }
    }
    
    private func resetAllButtons(){
        for button in cardButtons {
            button.isEnabled = true
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : game.gameTheme.colors[1]
        ]
        let attributedString = NSAttributedString(string: "Flips \(game.flipsInGame)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func checkIfAnyCardsAreLeft() -> Bool {
        for card in game.cards {
            if !card.isMatched {
                return true
            }
        }
        return false
    }
    
    func checkIfHighscoreIsBeaten(withScore score: Int) -> Bool {
        if self.record == 0 {
            return true
        }
        if score < self.record {
            return true
        }
        return false
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex  = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arch4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private func setColorsForAllViewRelatedProperties(){
        let color = game.gameTheme.colors[1]
        self.flipCountLabel.textColor = color
        self.recordLabel.textColor = color
        self.scoreLabel.textColor = color
    }
}

extension Int {
    var arch4random: Int {
        if(self > 0){
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
