//
//  ShootingHero.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/29/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

enum ShootingState {
    case AwaitingStart, Idle, Moving, Dead
}

class ShootingHero : SKNode {
    var sprite : SKSpriteNode = SKSpriteNode(imageNamed: "10sechero.png")
    var sound : SKAction = SKAction.playSoundFileNamed("drop.caf", waitForCompletion: false)
    var currentState : ShootingState = .AwaitingStart
    
    override init() {
        super.init()
        
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if( currentState == .AwaitingStart ) {
            self.physicsBody = SKPhysicsBody(rectangleOfSize: self.sprite.size)
            self.physicsBody?.categoryBitMask = Collisions.Player
            self.physicsBody?.collisionBitMask = Collisions.None
            self.physicsBody?.contactTestBitMask = Collisions.All - Collisions.Level - Collisions.Shoot
            self.physicsBody?.affectedByGravity = false
            
            currentState = .Idle
        }
        
        if( currentState == .Idle ) {
     
            for touch : AnyObject in touches {
                var location = touch.locationInNode(self)
            
                if(abs(Int(location.y - self.position.y)) < 250) {
                    currentState = .Moving
                }
            }
            
            self.runAction(SKAction.repeatActionForever(SKAction.sequence([
                    SKAction.runBlock({
                        self.createShoot()
                    }),
                    SKAction.waitForDuration(1.0)
                ])))
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if( currentState == .Moving ) {
            var minDist : Float = 250.0
            var chosenY : CGFloat = self.position.y
            var changed : Bool = false
            
            for touch : AnyObject in touches {
                var location = touch.locationInNode(parent)

                var distance : Float = Float(abs(Int(location.y - self.position.y)))
                
                if( distance < minDist ) {
                    chosenY = location.y
                    minDist = distance
                    changed = true
                }
            }
            
            if( !changed ) {
                self.removeAllActions()
                currentState = .Idle
                removeAllActions()
            } else {
                self.position.y = chosenY
            }
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        if(currentState == .Moving) {
            currentState = .Idle
            removeAllActions()
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if(currentState == .Moving) {
            currentState = .Idle
            removeAllActions()
        }
    }
    
    func createShoot() {
        (parent as ShootingScene).createShoot()
        AudioManager.playSound("explosion")
    }
    
    
    func die() {
        self.currentState = .Dead
    }
}