//
//  OptionsViewController.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/31/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import UIKit

class OptionsViewController : UIViewController {
    
    @IBOutlet weak var musicVolumeSlider: UISlider!
    @IBOutlet weak var soundVolumeSlider: UISlider!
    
    @IBAction func saveClick(sender: AnyObject) {
        AudioManager.musicVolume = musicVolumeSlider.value
        AudioManager.soundVolume = soundVolumeSlider.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
