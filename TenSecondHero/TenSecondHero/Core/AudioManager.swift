//
//  AudioManager.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/31/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import AVFoundation

public struct AudioManager {
    static var musicPlayer : AVAudioPlayer = AVAudioPlayer()
    static var soundPlayer : AVAudioPlayer = AVAudioPlayer()
    
    static var musicVolume : Float = 100.0
    static var soundVolume : Float = 100.0

    static public func playMusic(file : String ) {
        var file : NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(file, ofType: "aifc")!)!
        var error : NSError?
        musicPlayer = AVAudioPlayer(contentsOfURL: file, error: &error )
    
        musicPlayer.numberOfLoops = -1
        musicPlayer.volume = musicVolume / 100.0
        musicPlayer.prepareToPlay()
        musicPlayer.play()
    }
    
    static public func playSound(file : String ) {
        var file : NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(file, ofType: "caf")!)!
        var error : NSError?
        soundPlayer = AVAudioPlayer(contentsOfURL: file, error: &error )
        
        soundPlayer.numberOfLoops = 0
        soundPlayer.volume = soundVolume / 100.0
        soundPlayer.prepareToPlay()
        soundPlayer.play()
    }
}