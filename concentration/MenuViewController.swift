//
//  MenuViewController.swift
//  concentration
//
//  Created by Ricardo van Burik on 20-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var chosenTheme: Theme = ThemeFactory.randomTheme.theme
    
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var randomThemeSwitch: UISwitch! {
        didSet {
            updateViewWhenRandomThemeSwitchIsOn()
        }
    }
    
    @IBOutlet weak var difficultySlider: UISlider!
    
    override func viewDidLoad(){
        super.viewDidLoad();
        randomThemeSwitch.addTarget(self, action: #selector(updateViewWhenRandomThemeSwitchIsOn), for: .valueChanged)
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
                gameVC.game = Concentration(numberOfPairsOfCard: gameVC.numberOfPairsOfCard, gameTheme: chosenTheme)
            }
        }
    }
    
    @IBAction func unWindToHomeScreen(unwindSegue: UIStoryboardSegue){}

    func setThemes(){
        let value = getFinalValueOfSlider(withSlider: self.difficultySlider)
        var allThemes: [Theme]
        if value < 1 {
            allThemes = ThemeFactory.getThemesByDifficulty(difficulty: Theme.Difficulty.easy)
        }
        else if value > 1 && value <= 2 {
            allThemes = ThemeFactory.getThemesByDifficulty(difficulty: Theme.Difficulty.medium)
        }
        else {
            allThemes = ThemeFactory.getThemesByDifficulty(difficulty: Theme.Difficulty.hard)
        }
        
        allThemes.shuffle()
        if let theme = allThemes.first {
            self.chosenTheme = theme
        }
    }
    
    private func getFinalValueOfSlider(withSlider slider: UISlider) -> Float{
        return slider.value
    }
    
    @IBAction func startGame(){
        setThemeOfGameByRandomSwitch()
        performSegue(withIdentifier: "toGameSegue", sender: self)
    }
    
    func setThemeOfGameByRandomSwitch(){
        if self.randomThemeSwitch.isOn {
            self.chosenTheme = ThemeFactory.randomTheme.theme
        }
        else {
            setThemes()
        }
    }
    
    @objc private func updateViewWhenRandomThemeSwitchIsOn(){
        if(self.randomThemeSwitch.isOn){
            self.difficultySlider.isEnabled = false
        }
        else {
            self.difficultySlider.isEnabled = true

        }
    }
    
}
