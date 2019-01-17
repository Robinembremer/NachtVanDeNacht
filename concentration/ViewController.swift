//
//  ViewController.swift
//  concentration
//
//  Created by Ricardo van Burik on 05-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var finalTitle: UILabel!
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    private(set) var scoreCount = 0 {
        didSet{
            scoreLabel.text = "Score: \(scoreCount)"
        }
    }
    
    private var hardDifficulty: Bool = false
    private let playerController = AVPlayerViewController()
    
    private var record = 0 {
        didSet {
            recordLabel.text = "Highscore: \(record)"
        }
    }
    
    private var img = [Card:[String]]()
    
    var numberOfPairsOfCard: Int {
        if let numberOfCards = cardButtons?.count {
            return (numberOfCards + 1) / 2
        }
        return 10
    }
    
    lazy var game = Concentration(numberOfPairsOfCard: numberOfPairsOfCard, hardDifficulty: self.hardDifficulty)
    
    //OUTLETS
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var recordLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!

    @IBOutlet private var cardButtons: [UIButton]!
    
    private lazy var imgChoices = DataController().imageURLs
    
    override func viewDidLoad() {
        updateViewFromModel()
        self.finalTitle.isHidden = true
        self.mainStack.isHidden = false
        self.imageView.isHidden = true
        self.backButton.isHidden = true
        self.buttonSetup()
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
        resetAllButtons()
        updateViewFromModel()
    }
    
    private func enableFinalTitle(){
        let score: Int
        if self.scoreCount > 0 && self.scoreCount <= 50 {
            score = 100 / self.scoreCount * 5
        }
        else {
            score = 10
        }
        self.finalTitle.text = "Met uw score kon het licht in \(score)% van Nederland uit!"
        self.finalTitle.isHidden = false
        self.backButton.isHidden = false
        self.imageView.isHidden = false
        self.mainStack.isHidden = true
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            
            let button = cardButtons[index]
            let card = game.cards[index]
            button.imageView!.contentMode = .scaleAspectFit
            
            button.layer.borderWidth = 0
            if card.isMatched, button.isEnabled {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    button.layer.borderWidth = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.setBackgroundImage(nil, for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    button.isEnabled = false;
                }
                
            }
            
            if card.isFaceUp {
                button.setBackgroundImage(UIImage(named: card.imageURL), for: .normal)
            }
            else {
                button.setTitle("", for: .normal)
                button.setBackgroundImage(nil, for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            }
        }
        scoreCount = game.pointsInGame
        if !checkIfAnyCardsAreLeft() {
            playVideo()
            self.enableFinalTitle()
            if checkIfHighscoreIsBeaten(withScore: game.flipsInGame) {
                    record = (game.flipsInGame / 2) + scoreCount
            }
        }
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "EindVideoLittleStar", ofType:"mp4") else {
            debugPrint("Introvideo not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.player = player
        present(playerController, animated: false) {
            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            self.playerController.showsPlaybackControls = false
            player.play()
            
        }
        
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        playerController.dismiss(animated: false)
        
        
    }
    
    private func resetAllButtons(){
        for button in cardButtons {
            button.isEnabled = true
        }
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
    
    private func buttonSetup(){
        backButton.layer.cornerRadius = 25
        backButton.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        backButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
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
