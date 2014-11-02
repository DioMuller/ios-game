//
//  HighScore.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 11/2/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import Foundation

class HighScores {
    private var userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var mainGameHighscore : Int {
        get {
            if let value = userDefaults.valueForKey("highscoreGameMain") as? Int {
                return value
            }
            else {
                return 0
            }
        }
        set (value) {
            if( value > mainGameHighscore ) {
                userDefaults.setValue(value, forKey: "highscoreGameMain")
                userDefaults.synchronize()
            }
        }
    }
    
    func getHighscoreForGame(game : Int) -> Int {
        if( game == Minigames.MainGame ) {
            return mainGameHighscore
        } else if let value = userDefaults.valueForKey("highscoreGame" + String(game)) as? Int {
            return value
        }
        else {
            return 0
        }
    }
    
    func setHighscoreForGame(game : Int, score : Int) {
        if( game == Minigames.MainGame ) {
            mainGameHighscore = score
        } else if( score > mainGameHighscore ) {
            userDefaults.setValue(score, forKey: "highscoreGame" + String(game))
            userDefaults.synchronize()
        }
    }
}