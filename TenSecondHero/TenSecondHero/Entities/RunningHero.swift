//
//  RunningHero.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/30/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

enum RunningState {
    case AwaitingStart, Running, Jumping, Dead
}

class RunningHero : SKNode {
    var sprite : SKSpriteNode = SKSpriteNode(imageNamed: "strongman01.png")
    var sound : SKAction = SKAction.playSoundFileNamed("drop.caf", waitForCompletion: false)
    var currentState : RunningState = .AwaitingStart
    
    override init() {
        super.init()
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size, center: sprite.position)
        self.physicsBody?.affectedByGravity = true
        
        self.physicsBody?.categoryBitMask = Collisions.Player
        self.physicsBody?.collisionBitMask = Collisions.All
        self.physicsBody?.contactTestBitMask = Collisions.All - Collisions.Level
        
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if( currentState == .AwaitingStart ) {
            currentState = .Running
        }
        if( currentState == .Running ) {
            self.physicsBody?.velocity = CGVectorMake(0, 0)
            self.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 20.0))
            self.runAction(sound)
            self.currentState = .Jumping
        }
    }
    
    func hitGround() {
        self.currentState = .Running
    }
    
    func die() {
        self.currentState = .Dead
    }
}