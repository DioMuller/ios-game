//
//  MainGame.swift
//  TenSecondHero
//
//  Created by pucpr on 25/10/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

class GameScene : SKScene, SKPhysicsContactDelegate {
    // Current Scene displayed
    var currentScene : BaseScene = FlappyScene()
    
    override func didMoveToView(view: SKView) {
        addChild(currentScene)
        
        currentScene.onStartScene()
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = Collisions.Level
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        currentScene.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        currentScene.didBeginContact(contact)
    }
    
    
}
