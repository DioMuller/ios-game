//
//  OptionsViewController.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/31/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import UIKit

class OptionsViewController : UIViewController {
    
    @IBOutlet weak var sliderMusicVolume: UISlider!
    @IBOutlet weak var sliderSoundVolume: UISlider!
    

    @IBAction func musicVolumeChanged(sender: UISlider) {
        AudioManager.musicVolume = sender.value
    }
    
    @IBAction func soundVolumeChanged(sender: AnyObject) {
        AudioManager.soundVolume = sender.value
        AudioManager.playSound("explosion")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderMusicVolume.value = AudioManager.musicVolume
        sliderSoundVolume.value = AudioManager.soundVolume
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer.enabled = false
    }
    
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
