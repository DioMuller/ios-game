//
//  SpaceScene.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/29/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class SpaceScene : BaseScene {
    var hero : SpaceHero = SpaceHero()
    var background : ParallaxBackground = ParallaxBackground()
    
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
        
        enemyTextures = Animation.generateTextures("spaceenemy.png", xOffset: 1.0, yOffset: 0.25)
        // Loop Texture
        enemyTextures.append(enemyTextures[2])
        enemyTextures.append(enemyTextures[1])
        
        background = ParallaxBackground(imageNamed: "background_nightsky.png", size: self.scene!.size, velocity: 0.1)
        addChild(background)
        
        hero.position = CGPoint(x: 100, y: 100)
        addChild(hero)
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock(createEnemy),
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
        contact.bodyA.node?.removeFromParent()
        contact.bodyB.node?.removeFromParent()
        
        let blood : SKEmitterNode = SKEmitterNode(fileNamed: "Blood.sks")
        blood.position = contact.bodyA.node!.position
        blood.runAction(SKAction.sequence([
            SKAction.waitForDuration(1.0),
            SKAction.runBlock({blood.removeFromParent()})
            ]))
        addChild(blood)
        AudioManager.playSound("explosion")
        
        if( contact.bodyA.categoryBitMask == Collisions.Player || contact.bodyB.categoryBitMask == Collisions.Player ) {
            endLevel()
        } else {
            self.rootParent?.addScore(1)
        }
    }
    
    func createEnemy() {
        var newEnemy = SKSpriteNode(texture: enemyTextures[0])
        newEnemy.physicsBody = SKPhysicsBody(rectangleOfSize: newEnemy.size)
        
        let xPos : Int = (Int(size.width)) + Int(newEnemy.size.width)
        let yPos = Int(rand()) % Int(size.height)
        
        newEnemy.position = CGPoint(
            x: xPos,
            y: yPos
        )
        
        /* Enemy Movement */
        newEnemy.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveToX(-30, duration: 5.0),
                SKAction.runBlock({
                    let xPos : Int = (Int(self.size.width)) + Int(newEnemy.size.width)
                    let yPos = Int(rand()) % Int(self.size.height)
                    
                    newEnemy.position = CGPoint(
                        x: xPos,
                        y: yPos
                    )
                })
                ])
            ))
        
        /* Enemy Animation */
        newEnemy.runAction(SKAction.repeatActionForever(
                SKAction.animateWithTextures(enemyTextures, timePerFrame: 0.1)
            ))
        
        newEnemy.physicsBody = SKPhysicsBody(rectangleOfSize: newEnemy.size)
        newEnemy.physicsBody?.categoryBitMask = Collisions.Obstacle
        newEnemy.physicsBody?.affectedByGravity = false
        newEnemy.physicsBody?.collisionBitMask = Collisions.None

        addChild(newEnemy)
    }
    
    func createShoot() {
        var shoot : SKSpriteNode = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 15, height: 5))
        shoot.position = hero.position
        
        if( self.scene != nil ) {
            shoot.runAction(SKAction.sequence([
                SKAction.moveToX(self.scene!.size.width + 40, duration: 2.0),
                SKAction.runBlock({
                        shoot.removeFromParent()
                    })
                ]))
        
            shoot.physicsBody = SKPhysicsBody(rectangleOfSize: shoot.size)
            shoot.physicsBody?.categoryBitMask = Collisions.Shoot
            shoot.physicsBody?.collisionBitMask = Collisions.None
            shoot.physicsBody?.contactTestBitMask = Collisions.All - Collisions.Level - Collisions.Player
            shoot.physicsBody?.affectedByGravity = false
        
            self.addChild(shoot)
        }
    }
}