//
//  ShooterScene.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 11/2/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class ShooterScene : BaseScene {
    var ground : SKSpriteNode = SKSpriteNode()
    var enemyTextures : [SKTexture] = []
    var background : SKSpriteNode = SKSpriteNode(imageNamed: "background_afternoonsky.png")
    
    var size : CGSize = CGSize()
    var levelEnded : Bool = false
    
    override init() {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var sceneMusic : String {
        get { return "SaveMe" }
    }
    
    public override func onStartScene() {
        super.onStartScene()
        
        size = self.scene!.size
        
        enemyTextures = Animation.generateTextures("bomb.png", xOffset: 0.5, yOffset: 1.0)
        
        background.size = size
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock(createObstacle),
            SKAction.waitForDuration(1.0)
            ])))
    }
    
    public override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch : AnyObject in touches {
            var location = touch.locationInNode(self)
            
            var objects : [AnyObject] = self.nodesAtPoint(location)
            
            for object : AnyObject in objects {
                
                if( (object as? SKSpriteNode)?.name == "Bomb" ) {
                
                    let smoke : SKEmitterNode = SKEmitterNode(fileNamed: "Smoke.sks")
                    smoke.position = location
                    addChild(smoke)
                
                    object.removeAllActions()
                    object.removeFromParent()
                    self.rootParent?.addScore(1)
                }
            }
        }
    }
    
    
    func createObstacle() {
        var newObstacle : SKSpriteNode = SKSpriteNode(texture: enemyTextures[0])
        
        
        newObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: newObstacle.size)
        
        let xPos : Int = Int(rand()) % Int(self.size.width)
        let yPos = 10
        
        let distanceFromCenter : CGFloat = CGFloat(xPos) - (self.size.width / 2)
        
        newObstacle.position = CGPoint(
            x: xPos,
            y: yPos
        )
        
        /* Enemy Animation */
        newObstacle.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(enemyTextures, timePerFrame: 0.1)
            ))
        
        
        newObstacle.physicsBody = SKPhysicsBody(rectangleOfSize: newObstacle.size)
        newObstacle.physicsBody?.categoryBitMask = Collisions.Obstacle
        newObstacle.physicsBody?.affectedByGravity = true
        newObstacle.physicsBody?.collisionBitMask = Collisions.None
        
        newObstacle.name = "Bomb"
        
        if( distanceFromCenter != 0 ) {
            newObstacle.physicsBody?.velocity = CGVectorMake(-distanceFromCenter / abs(distanceFromCenter) * 200, 800)
        } else {
            newObstacle.physicsBody?.velocity = CGVectorMake(0, 800)
        }
        
        newObstacle.runAction(SKAction.sequence([
                SKAction.waitForDuration(1),
                SKAction.fadeOutWithDuration(0.5),
                SKAction.runBlock({
                    newObstacle.removeFromParent()
                    if( !self.levelEnded ) {
                        AudioManager.playSound("explosion")
                        self.levelEnded = true
                    }
                    self.endLevel()
                })
            ]))
        
        addChild(newObstacle)
    }
}
