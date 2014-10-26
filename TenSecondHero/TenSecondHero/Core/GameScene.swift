//
//  MainGame.swift
//  TenSecondHero
//
//  Created by pucpr on 25/10/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

class GameScene : SKScene {
    // Current Scene displayed
    var currentScene : BaseScene = TestScene()
    
    override func didMoveToView(view: SKView) {
        addChild(currentScene)
        
        currentScene.onStartScene()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}
