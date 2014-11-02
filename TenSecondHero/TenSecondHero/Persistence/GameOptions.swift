//
//  GameOptions.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 11/2/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import Foundation

class GameOptions {
    private var userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    // Music Volume
    var musicVolume : Float {
        get {
            if let value = userDefaults.valueForKey("musicVolume") as? Float {
                return value
            }
            else {
                return 1.0
            }
        }
        set (value) {
            userDefaults.setValue(value, forKey: "musicVolume")
            userDefaults.synchronize()
        }
    }
    
    // Sound Volume
    var soundVolume : Float {
        get {
            if let value = userDefaults.valueForKey("soundVolume") as? Float {
                return value
            }
            else {
                return 1.0
            }
        }
        set (value) {
            userDefaults.setValue(value, forKey: "soundVolume")
            userDefaults.synchronize()
        }
    }
}