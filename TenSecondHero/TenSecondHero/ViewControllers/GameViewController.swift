//
//  GameViewController.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/25/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameDelegate {
    var scene : GameScene?
    var index : Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer.enabled = false
        
        let currentView : SKView = self.view as SKView
        currentView.showsFPS = false
        
        scene = GameScene(size: currentView.bounds.size)
        scene?.nextLevel = index
        scene?.gameDelegate = self
        currentView.presentScene(scene)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated : Bool ) {
        let currentView : SKView = self.view as SKView
        
        scene?.gameDelegate = nil
        scene = nil
        currentView.presentScene(nil)
    }
    
    func gameOver(gameType : Int, score: Int) {
        HighScores().setHighscoreForGame(gameType, score: score)
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("TitleViewController") as TitleViewController
        navigationController?.pushViewController(viewController, animated: true)*/
        navigationController?.popViewControllerAnimated(true)
    }
    
}
