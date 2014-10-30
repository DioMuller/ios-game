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
    var currentScene : BaseScene = RunningScene()
    var score : Int = 0
    
    var scoreText : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMoveToView(view: SKView) {
        addChild(currentScene)
        
        currentScene.onStartScene()
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = Collisions.Level
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        
        self.physicsWorld.contactDelegate = self
        
        scoreText.text = "Score: \(score)"
        scoreText.position = CGPoint(x: 80, y: 30)
        scoreText.fontColor = UIColor.redColor()
        addChild(scoreText)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        currentScene.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        currentScene.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        currentScene.touchesEnded(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        currentScene.touchesCancelled(touches, withEvent: event)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        currentScene.didBeginContact(contact)
    }
    
    func addScore(points : Int) {
        score += points
        scoreText.text = "Score: \(score)"
    }
    
}
