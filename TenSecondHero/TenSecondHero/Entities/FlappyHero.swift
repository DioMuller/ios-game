//
//  Hero.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/26/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

class FlappyHero : SKNode {
    var sprite : SKSpriteNode = SKSpriteNode(imageNamed: "10sechero.png")
    
    override init() {
        super.init()
        
        addChild(sprite)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size, center: sprite.position)
        self.physicsBody?.affectedByGravity = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.physicsBody?.velocity = CGVectorMake(0, 0)
        self.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 15.0))
    }
}
