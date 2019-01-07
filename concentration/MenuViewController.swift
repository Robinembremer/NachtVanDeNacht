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
        
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    @IBAction func printLevelSliderOutput(_ sender: UISlider){
        print("Slider output: \(sender.value)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameSegue" {
            if let gameVC = segue.destination as? ViewController {
                gameVC.game = Concentration(numberOfPairsOfCard: gameVC.numberOfPairsOfCard)
            }
        }
    }
    
    @IBAction func unWindToHomeScreen(unwindSegue: UIStoryboardSegue){}
    
    @IBAction func startGame(){
        performSegue(withIdentifier: "toGameSegue", sender: self)
    }
    
}
