//
//  Hero.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/26/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

enum FlappyState {
    case AwaitingStart, Playing, Dead
}

class FlappyHero : SKNode {
    var sprite : SKSpriteNode = SKSpriteNode()
    var currentState : FlappyState = .AwaitingStart
    
    override init() {
        super.init()
        
        var animations : [SKTexture] = Animation.generateTextures("flyinghero.png", xOffset: 1.0, yOffset: 0.5)
        sprite = SKSpriteNode(texture: animations[0])
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(animations, timePerFrame: 0.2)
            ))
        
        addChild(sprite)
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if( currentState == .AwaitingStart ) {
            currentState = .Playing
            self.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size, center: sprite.position)
            self.physicsBody?.affectedByGravity = true

            self.physicsBody?.categoryBitMask = Collisions.Player
            self.physicsBody?.collisionBitMask = Collisions.All
            self.physicsBody?.contactTestBitMask = Collisions.All - Collisions.Level
        }
         if( currentState == .Playing ) {
            self.physicsBody?.velocity = CGVectorMake(0, 0)
            self.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 15.0))
            AudioManager.playSound("drop")
        }
    }
    
    func die() {
        self.currentState = .Dead
    }
}
