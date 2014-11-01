//
//  MainGame.swift
//  TenSecondHero
//
//  Created by pucpr on 25/10/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

struct Minigames {
    static var Flap : Int = 0
    static var Shoot : Int = 1
    static var Run : Int = 2
    
    static var Count = 3
    
    static func getTitle(type : Int ) -> String {
        switch(type) {
            case Flap:
                return "Flap"
            case Shoot:
                return "Shoot"
            case Run:
                return "Run"
            default:
                return "Error"
        }
    }
}

class GameScene : SKScene, SKPhysicsContactDelegate {
    // Current Scene displayed
    var currentScene : BaseScene = BaseScene()
    var score : Int = 0
    
    var scoreText : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    var nextLevel : Int = 0
    
    override func didMoveToView(view: SKView) {
        
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
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock({self.chooseNext()}),
            SKAction.runBlock({self.loadTransition()}),
            SKAction.waitForDuration(3.0),
            SKAction.runBlock({self.loadNext()}),
            SKAction.waitForDuration(10.0)
        ])))
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
    
    func loadTransition() {
        currentScene.removeFromParent()
        scoreText.removeFromParent()
        
        currentScene = TransitionScene(message: Minigames.getTitle(nextLevel))
        
        addChild(currentScene)
        currentScene.onStartScene()
        addChild(scoreText)
    }
    
    func loadNext(){
        
        currentScene.removeFromParent()
        scoreText.removeFromParent()
        
        switch(nextLevel) {
            case Minigames.Flap:
                currentScene = FlappyScene()
                break
            case Minigames.Shoot:
                currentScene = ShootingScene()
                break
            case Minigames.Run:
                currentScene = RunningScene()
                break
            default:
                chooseNext()
                loadNext()
        }
        
        addChild(currentScene)
        currentScene.onStartScene()
        addChild(scoreText)
    }
    
    func chooseNext() {
        nextLevel = random() % Minigames.Count
    }
    
}
