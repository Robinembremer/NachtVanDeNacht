//
//  DetailViewController.swift
//  concentration
//
//  Created by Ricardo van Burik on 24-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var gameThemes = ThemeFactory.allThemes
    var choosenTheme = ThemeFactory.emojis.theme
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return gameThemes.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameThemeCell", for: indexPath)
        
        let gameTheme = gameThemes[indexPath.row]
        
        cell.textLabel?.text = gameTheme.theme.icons
        cell.detailTextLabel?.text = "Difficulty: \(gameTheme.theme.difficulty.rawValue)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "overviewSegue" {
            if let gameVC = segue.destination as? ViewController {
                gameVC.game = Concentration(numberOfPairsOfCard: gameVC.numberOfPairsOfCard, gameTheme: self.choosenTheme)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.choosenTheme = gameThemes[indexPath.row].theme
        performSegue(withIdentifier: "overviewSegue", sender: self)
    }
    
    
}
