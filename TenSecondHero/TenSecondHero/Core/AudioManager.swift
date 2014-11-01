//
//  AudioManager.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/31/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import AVFoundation

public struct AudioManager {
    static var musicPlayer : AVAudioPlayer?
    static var soundPlayer : AVAudioPlayer?
    
    static var internalMusicVolume : Float = 1.0
    static var internalSoundVolume : Float = 1.0
    
    static var musicVolume : Float {
        get {
            return internalMusicVolume
        }
        set(value) {
            musicPlayer?.volume = value
            internalMusicVolume = value
        }
    }
    
    static var soundVolume : Float {
        get {
            return internalSoundVolume
        }
        set(value) {
            soundPlayer?.volume = value
            internalSoundVolume = value
        }
    }

    static public func playMusic(file : String ) {
        var file : NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(file, ofType: "aifc")!)!
        var error : NSError?
        musicPlayer = AVAudioPlayer(contentsOfURL: file, error: &error )
    
        musicPlayer?.numberOfLoops = -1
        musicPlayer?.volume = musicVolume
        musicPlayer?.prepareToPlay()
        musicPlayer?.play()
    }
    
    static public func playSound(file : String ) {
        var file : NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(file, ofType: "caf")!)!
        var error : NSError?
        soundPlayer = AVAudioPlayer(contentsOfURL: file, error: &error )
        
        soundPlayer?.numberOfLoops = 0
        soundPlayer?.volume = soundVolume
        soundPlayer?.prepareToPlay()
        soundPlayer?.play()
    }
}