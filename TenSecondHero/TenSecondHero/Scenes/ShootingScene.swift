//
//  ShootingScene.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/29/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class ShootingScene : BaseScene {
    var hero : ShootingHero = ShootingHero()
    var background : ParallaxBackground = ParallaxBackground()
    var ground : SKSpriteNode = SKSpriteNode()
    var obstacles : [SKSpriteNode] = []
    var shoots : [SKSpriteNode] = []
    
    var size : CGSize = CGSize()
    
    override init() {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func onStartScene() {
        super.onStartScene()
        
        size = self.scene!.size
        
        background = ParallaxBackground(imageNamed: "background_nightsky.png", size: self.scene!.size, velocity: 0.1)
        addChild(background)
        
        hero.position = CGPoint(x: 100, y: 100)
        addChild(hero)
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock(createObstacle),
            SKAction.waitForDuration(17.5)
            ])))
    }
    
    public override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        hero.touchesBegan(touches, withEvent: event)
    }
    
    public override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        hero.touchesMoved(touches, withEvent: event)
    }
    
    override func didBeginContact(contact: SKPhysicsContact) {
        for obstacle : SKSpriteNode in obstacles {
            if( contact.bodyA == obstacle.physicsBody || contact.bodyB == obstacle.physicsBody ) {
                if( contact.bodyA == hero.physicsBody || contact.bodyB == hero.physicsBody ) {
                    hero.die()
                    destroy(obstacle)
                    background.stop()
                }
            }
        }
    }
    
    func createObstacle() {
        var newObstacle = SKSpriteNode(imageNamed: "piu01.png")
        newObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: newObstacle.size)
        
        let xPos : Int = (Int(size.width)) + Int(newObstacle.size.width)
        let yPos = Int(rand()) % Int(size.height)
        
        newObstacle.position = CGPoint(
            x: xPos,
            y: yPos
        )
        
        newObstacle.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveToX(-30, duration: 5.0),
                SKAction.runBlock({
                    let xPos : Int = (Int(self.size.width)) + Int(newObstacle.size.width)
                    let yPos = Int(rand()) % Int(self.size.height)
                    
                    newObstacle.position = CGPoint(
                        x: xPos,
                        y: yPos
                    )
                })
                ])
            ))
        
        newObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: newObstacle.size)
        newObstacle.physicsBody?.categoryBitMask = Collisions.Obstacle
        newObstacle.physicsBody?.affectedByGravity = false
        newObstacle.physicsBody?.collisionBitMask = Collisions.None
        
        obstacles.append(newObstacle)
        addChild(newObstacle)
    }
    
    func destroy(contact : SKSpriteNode) {
        contact.removeFromParent()
        // TODO: Remove from obstacles.
    }
    
    func createShoot() {
        
    }
}