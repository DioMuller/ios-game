//
//  TestScene.swift
//  TenSecondHero
//
//  Created by pucpr on 25/10/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class FlappyScene : BaseScene {
    var hero : FlappyHero = FlappyHero()
    var background : ParallaxBackground = ParallaxBackground()
    var ground : SKSpriteNode = SKSpriteNode()
    var obstacles : [SKSpriteNode] = []

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
      
        background = ParallaxBackground(imageNamed: "background_morningsky.png", size: self.scene!.size, velocity: 0.1)
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
            SKAction.waitForDuration(15.0)
            ])))
    }
    
    public override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        hero.touchesBegan(touches, withEvent: event)
    }
    
    override func didBeginContact(contact: SKPhysicsContact) {
        if( contact.bodyA == hero.physicsBody || contact.bodyB == hero.physicsBody ) {
            hero.die()
            background.stop()
        }
    }
    
    func createObstacle() {
        var newObstacle = SKSpriteNode(imageNamed: "hero_failure.png")
        newObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: newObstacle.size)
        
        let xPos : Int = (Int(size.width)) + Int(newObstacle.size.width)
        let yPos = Int(rand()) % Int(size.height)
        
        newObstacle.position = CGPoint(
            x: xPos,
            y: yPos
        )
        
        newObstacle.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveToX(-100.0, duration: 8.0),
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
}