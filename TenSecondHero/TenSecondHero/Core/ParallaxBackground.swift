//
//  ParallaxBackground.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/26/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class ParallaxBackground : SKNode {
    
    var images : [SKSpriteNode] = []
    var screenSize : CGSize = CGSize()
    let frameTime : Double = 0.0
    
    override init(){
        super.init()
    }
    
    init(imageNamed : String, size : CGSize, velocity : Double) {
        self.screenSize = size
        self.frameTime = 60 * velocity
        
        super.init()
        
        images.insert(SKSpriteNode(imageNamed: imageNamed), atIndex: 0)
        images[0].size = screenSize
        images[0].position = getPosition(CGPoint(x: 0,y: 0))
        images[0].runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveTo(getPosition(CGPoint(x: screenSize.width, y: screenSize.height)), duration: frameTime)
            ])
        ))
        self.addChild(images[0])
        
        images.insert(SKSpriteNode(imageNamed: imageNamed), atIndex: 0)
        images[0].size = screenSize
        images[0].position = getPosition(CGPoint(x: -screenSize.width,y: 0))
        images[0].runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveTo(getPosition(CGPoint(x: screenSize.width, y: screenSize.height)), duration: frameTime)
                ])
            ))
        self.addChild(images[0])
    }

    required public init?(coder aDecoder: NSCoder) {
        self.screenSize = CGSize(width: 0,height: 0)
        super.init(coder: aDecoder)
    }
    
    private func getPosition(point : CGPoint) -> CGPoint {
        return CGPoint(x: point.x + (screenSize.width / 2), y: point.y + (screenSize.height / 2))
    }
    
    
}
