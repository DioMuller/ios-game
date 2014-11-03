//
//  HighScore.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 11/2/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import Foundation

struct HighscoreInfo {
    var game : String
    var score : Int
    
    init( game : String, score : Int ){
        self.game = game
        self.score = score
    }
}

class HighScores {
    private var userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var list : [HighscoreInfo] {
        get {
            var scores : [HighscoreInfo] = []
            var i : Int = 0
        
            scores.append(HighscoreInfo(game: "Main Game", score: mainGameHighscore))
        
            for( i = 0; i < Minigames.Count; i++ ) {
                var info = Minigames.getInfo(i)
                scores.append(HighscoreInfo(game: info.title, score: getHighscoreForGame(i)))
            }
            
            return scores
        }
    }
    
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