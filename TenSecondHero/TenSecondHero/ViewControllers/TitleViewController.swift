//
//  ViewController.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/12/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import UIKit
import AVFoundation

class TitleViewController: UIViewController {
    var mediaPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var file : NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PressStart", ofType: "aifc")!)!
        var error : NSError?
        mediaPlayer = AVAudioPlayer(contentsOfURL: file, error: &error )
        
        mediaPlayer.numberOfLoops = -1
        mediaPlayer.prepareToPlay()
        mediaPlayer.play()
    }
    
    override func viewWillDisappear(animated: Bool) {
        mediaPlayer.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

