//
//  DrivingScene.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 11/3/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class DrivingScene : BaseScene {
    var hero : ForkliftHero = ForkliftHero()
    var background : ParallaxBackground = ParallaxBackground()
    
    var size : CGSize = CGSize()
    var obstacles : [String] = ["boycitizen01.png", "boycitizen02.png", "cat.png", "girlcitizen01.png",
        "girlcitizen02.png", "strongman01.png", "human.png", "hero_failure.png", "grandmacitizen01.png"]
    
    override init() {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func onStartScene() {
        super.onStartScene()
        
        size = self.scene!.size
        
        background = ParallaxBackground(imageNamed: "background_cement.png", size: self.scene!.size, velocity: 0.1)
        addChild(background)
        
        hero.position = CGPoint(x: 100, y: 100)
        addChild(hero)
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock(createObstacle),
            SKAction.waitForDuration(1.5)
            ])))
    }
    
    public override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        hero.touchesBegan(touches, withEvent: event)
    }
    
    public override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        hero.touchesMoved(touches, withEvent: event)
    }
    
    public override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        hero.touchesEnded(touches, withEvent: event)
    }
    
    public override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        hero.touchesCancelled(touches, withEvent: event)
    }
    
    override func didBeginContact(contact: SKPhysicsContact) {
        if( contact.bodyA.categoryBitMask == Collisions.Player || contact.bodyB.categoryBitMask == Collisions.Player ) {
            if( contact.bodyA.categoryBitMask != Collisions.Player ) { contact.bodyA.node?.removeFromParent() }
            if( contact.bodyB.categoryBitMask != Collisions.Player ) { contact.bodyB.node?.removeFromParent() }
            
            let blood : SKEmitterNode = SKEmitterNode(fileNamed: "Blood.sks")
            blood.position = contact.bodyA.node!.position
            blood.runAction(SKAction.sequence([
                SKAction.waitForDuration(1.0),
                SKAction.runBlock({blood.removeFromParent()})
                ]))
            addChild(blood)
            
            AudioManager.playSound("explosion")
            endLevel()
        }
    }
    
    func createObstacle() {
        var newObstacle = SKSpriteNode(imageNamed: obstacles[random() % obstacles.count] )
        newObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: newObstacle.size)
        
        let xPos : Int = (Int(size.width)) + Int(newObstacle.size.width)
        let yPos = Int(rand()) % Int(size.height)
        
        newObstacle.position = CGPoint(
            x: xPos,
            y: yPos
        )
        
        /* Enemy Movement */
        var action = SKAction.sequence([
                SKAction.moveToX(80.0, duration: 5.0),
                SKAction.runBlock(addToScore),
                SKAction.moveToX(-30, duration: 1.0),
                SKAction.runBlock({newObstacle.removeFromParent()})
            ])

        newObstacle.runAction(action)
        
        newObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: newObstacle.size)
        newObstacle.physicsBody?.categoryBitMask = Collisions.Obstacle
        newObstacle.physicsBody?.affectedByGravity = false
        newObstacle.physicsBody?.collisionBitMask = Collisions.None
        
        addChild(newObstacle)
    }

    func addToScore(){
        if( hero.currentState == DrivingState.Moving || hero.currentState == DrivingState.Idle ) {
            self.rootParent?.addScore(1)
        }
    }
}