//
//  Theme.swift
//  concentration
//
//  Created by Ricardo van Burik on 17-09-18.
//  Copyright © 2018 Ricardo van Burik. All rights reserved.
//

import Foundation
import UIKit

enum ThemeFactory {
    
    static var randomTheme: ThemeFactory {
        get {
            allThemes.shuffle()
            return allThemes.first!
        }
    }
                
    case sport
    case flags
    case food
    case halloween
    case vehicles
    case trees
    case emojis
    case time
    
    
    static var allThemes = [ThemeFactory.food, .sport, .halloween, .vehicles, .trees, .emojis, .time, .flags]
    
    static func getThemesByDifficulty(difficulty: Theme.Difficulty) -> [Theme]{
        var allThemesByDifficulty = [Theme]()
        for theme in allThemes {
            if theme.theme.difficulty == difficulty {
                allThemesByDifficulty.append(theme.theme)
            }
        }
        return allThemesByDifficulty
    }
    
    var theme : Theme {
        switch self {
        case .sport: return Theme(icons: "⚽️🏀🏈⚾️🎾🏐🏉🎱🥅🥊", colors: [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)], difficulty: .easy)
        case .flags: return Theme(icons: "🇦🇴🇦🇲🇦🇺🇧🇪🇧🇯🇧🇦🇧🇷🇨🇦🇨🇷🇩🇰", colors: [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)], difficulty: .easy)
        case .food: return Theme(icons: "🍏🍊🍑🍞🍕🥒🥐🥞🥨🥟", colors: [#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)], difficulty: .medium)
        case .halloween: return Theme(icons: "🔪🗡⚔️🛡💈🔮⚰️🕸🕷👻", colors: [#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)], difficulty: .medium)
        case .vehicles: return Theme(icons: "🚗🚕🚙🚌🚎🏎🚜🚛🚚🚒", colors: [#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)], difficulty: .medium)
        case .trees: return Theme(icons: "🌲🌳🌴🌱🌿☘️🍀🌵🎄🎋", colors: [#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)], difficulty: .hard)
        case .emojis: return Theme(icons: "😀😃😄😁😆☺️😊🙂🙃😛", colors: [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)], difficulty: .hard)
        case .time: return Theme(icons: "🕐🕑🕒🕓🕔🕕🕖🕗🕘🕙", colors: [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)], difficulty: .hard)
        
            
        }
    
    }
}

