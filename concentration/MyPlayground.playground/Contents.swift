//: Playground - noun: a place where people can play

import UIKit
import Foundation

enum Theme {
    case food
    case sport
    case halloween
    
    static private var allThemes = [Theme.food, .sport, .halloween]
    
    var themes : String {
        switch self {
        case .food: return "🍏🍊🍑🍞🍕🥒🥐🥞🥨🥟"
        case .sport: return "⚽️🏀🏈⚾️🎾🏐🏉🎱🥅🥊"
        case .halloween: return "🔪🗡⚔️🛡💈🔮⚰️🕸🕷👻"
        
        }
        
    }
    
    static func getRandomTheme() -> String {
        allThemes.shuffle()
        let randomTheme = allThemes[0]
        print(randomTheme)
        return themes.randomTheme
    }
    
}

extension Array {
    mutating func shuffle() {
        for _ in indices {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

