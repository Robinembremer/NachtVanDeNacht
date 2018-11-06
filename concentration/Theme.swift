//
//  Theme.swift
//  concentration
//
//  Created by Ricardo van Burik on 17-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    
    var icons: String
    var colors: [UIColor]
    var difficulty: Difficulty
    
    init(icons: String, colors: [UIColor], difficulty: Difficulty){
        self.icons = icons
        self.colors = colors
        self.difficulty = difficulty
    }
    
    enum Difficulty: String {
        case easy = "easy"
        case medium = "medium"
        case hard = "hard"
    }
    
}
