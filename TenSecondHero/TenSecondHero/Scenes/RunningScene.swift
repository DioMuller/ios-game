//
//  RunningScene.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/30/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class RunningScene : BaseScene {
    var hero : RunningHero = RunningHero()
    var background : ParallaxBackground = ParallaxBackground()
    var ground : SKSpriteNode = SKSpriteNode()
    var enemyTextures : [SKTexture] = []
    
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
        enemyTextures = Animation.generateTextures("dog.png", xOffset: 1.0, yOffset: 0.5)
        
        background = ParallaxBackground(imageNamed: "background_city01.png", size: self.scene!.size, velocity: 0.1)
        addChild(background)
        
        ground = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: size.width, height: 50))
        ground.position = CGPoint(x: (size.width / 2), y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.categoryBitMask = Collisions.Ground
        ground.physicsBody?.contactTestBitMask = Collisions.Player
        addChild(ground)
        
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
    
    override func didBeginContact(contact: SKPhysicsContact) {
        if( contact.bodyA.categoryBitMask == Collisions.Player || contact.bodyB.categoryBitMask == Collisions.Player ) {
            if( contact.bodyA.categoryBitMask == Collisions.Ground || contact.bodyB.categoryBitMask == Collisions.Ground ) {
                hero.hitGround()
            } else {
                hero.die()
                background.stop()
            }
        }
    }
    
    func createObstacle() {
        var newObstacle = SKSpriteNode(texture: enemyTextures[0])
        
        newObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: newObstacle.size)
        
        let xPos : Int = (Int(size.width)) + Int(newObstacle.size.width)
        let yPos = Int(rand()) % Int(size.height)
        
        newObstacle.position = CGPoint(
            x: xPos,
            y: 35
        )
        
        newObstacle.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveToX(80.0, duration: 3.0),
                SKAction.runBlock({
                    if ( self.hero.currentState == RunningState.Running ) {
                        self.rootParent.addScore(1)
                    }
                }),
                SKAction.moveToX(-30, duration: 0.7),
                SKAction.runBlock({
                    let xPos : Int = (Int(self.size.width)) + Int(newObstacle.size.width)
                    let yPos = Int(rand()) % Int(self.size.height)
                    
                    newObstacle.position = CGPoint(
                        x: xPos,
                        y: 35
                    )
                })
                ])
            ))
        
        /* Enemy Animation */
        newObstacle.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(enemyTextures, timePerFrame: 0.1)
            ))
        
        newObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: newObstacle.size)
        newObstacle.physicsBody?.categoryBitMask = Collisions.Obstacle
        newObstacle.physicsBody?.affectedByGravity = false
        newObstacle.physicsBody?.collisionBitMask = Collisions.None

        addChild(newObstacle)
    }
}