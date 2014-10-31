//
//  ViewController.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/12/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioManager.playMusic("PressStart")
    }
    
    override func viewWillDisappear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

