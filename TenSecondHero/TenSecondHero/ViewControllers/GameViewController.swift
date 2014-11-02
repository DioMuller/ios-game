//
//  GameViewController.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/25/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentView : SKView = self.view as SKView
        currentView.showsFPS = false
        
        let scene : GameScene = GameScene(size: currentView.bounds.size)
        currentView.presentScene(scene)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
