//
//  MenuViewController.swift
//  concentration
//
//  Created by Ricardo van Burik on 20-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MenuViewController: UIViewController {
        
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var difficultyToggle: UISwitch!
    private let playerController = AVPlayerViewController()
    
    private var difficultyHard = false
    
    override func viewDidLoad(){
        super.viewDidLoad()
        playVideo()
        self.buttonSetup()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameSegue" {
            if let gameVC = segue.destination as? ViewController {
                gameVC.game = Concentration(numberOfPairsOfCard: gameVC.numberOfPairsOfCard, hardDifficulty: isDifficultyHard())
            }
        }
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "IntroVideoLittleStar", ofType:"mp4") else {
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
    
    @IBAction func unWindToHomeScreen(unwindSegue: UIStoryboardSegue){}
    
    private func isDifficultyHard() -> Bool {
        return self.difficultyToggle.isOn ? true : false
    }
    
    @IBAction func startGame(){
        performSegue(withIdentifier: "toGameSegue", sender: self)
    }
    
    private func buttonSetup(){
        playButton.layer.cornerRadius = 25
        playButton.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        playButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
}
