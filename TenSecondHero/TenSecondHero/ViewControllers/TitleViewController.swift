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
        
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer.enabled = false
        
        AudioManager.playMusic("PressStart")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer.enabled = false
        
        AudioManager.playMusic("PressStart")
    }
    
    override func viewWillDisappear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

