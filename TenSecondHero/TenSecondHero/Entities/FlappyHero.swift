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
    var sprite : SKSpriteNode = SKSpriteNode(imageNamed: "10sechero.png")
    var sound : SKAction = SKAction.playSoundFileNamed("drop.caf", waitForCompletion: false)
    var currentState : FlappyState = .AwaitingStart
    
    override init() {
        super.init()
        
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
            self.runAction(sound)
        }
    }
    
    func die() {
        self.currentState = .Dead
    }
}
