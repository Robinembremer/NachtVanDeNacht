//
//  MenuViewController.swift
//  concentration
//
//  Created by Ricardo van Burik on 20-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
        
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.buttonSetup()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameSegue" {
            if let gameVC = segue.destination as? ViewController {
                gameVC.game = Concentration(numberOfPairsOfCard: gameVC.numberOfPairsOfCard, hardDifficulty: false)
            }
        }
    }
    
    @IBAction func unWindToHomeScreen(unwindSegue: UIStoryboardSegue){}
    
    
    @IBAction func startGame(){
        performSegue(withIdentifier: "toGameSegue", sender: self)
    }
    
    private func buttonSetup(){
        playButton.layer.cornerRadius = 25
        playButton.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        playButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
}
