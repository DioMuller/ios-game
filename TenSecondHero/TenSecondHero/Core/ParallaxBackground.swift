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
    var frameTime : Double = 0.0
    var inverted : Bool = false
    
    override init(){
        super.init()
    }
    
    init(imageNamed : String, size : CGSize, velocity : Double) {
        self.screenSize = size
        self.frameTime = 60 * abs(velocity)
        self.inverted = (velocity < 0.0)
        
        super.init()
        
        images.insert(SKSpriteNode(imageNamed: imageNamed), atIndex: 0)
        images[0].size = screenSize
        
        images.insert(SKSpriteNode(imageNamed: imageNamed), atIndex: 1)
        images[1].size = screenSize

        images.insert(SKSpriteNode(imageNamed: imageNamed), atIndex: 2)
        images[2].size = screenSize

        
        if( !inverted ) {
            /* BG 1 */
            images[0].position = getPosition(CGPoint(x: 0,y: 0))
            images[0].runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.moveTo(getPosition(CGPoint(x: -screenSize.width, y: 0)), duration: frameTime),
                    SKAction.runBlock({self.images[0].position = self.getPosition(CGPoint(x: self.screenSize.width * 2,y: 0))}),
                    SKAction.moveTo(getPosition(CGPoint(x: 0, y: 0)), duration: frameTime * 2)
                    ])
                ))
            
            /* BG 2 */
            images[1].position = getPosition(CGPoint(x: screenSize.width,y: 0))
            images[1].runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.moveTo(getPosition(CGPoint(x: -screenSize.width, y: 0)), duration: frameTime * 2),
                    SKAction.runBlock({self.images[1].position = self.getPosition(CGPoint(x: self.screenSize.width * 2,y: 0))}),
                    SKAction.moveTo(getPosition(CGPoint(x: screenSize.width, y: 0)), duration: frameTime)
                    ])
                ))
            
            /* BG 3 */
            images[2].position = getPosition(CGPoint(x: screenSize.width * 2,y: 0))
            images[2].runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.moveTo(getPosition(CGPoint(x: -screenSize.width, y: 0)), duration: frameTime * 3),
                    SKAction.runBlock({self.images[2].position = self.getPosition(CGPoint(x: self.screenSize.width * 2,y: 0))})
                    ])
                ))
        } else {
            /* BG 1 */
            images[0].position = getPosition(CGPoint(x: 0,y: 0))
            images[0].runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.moveTo(getPosition(CGPoint(x: screenSize.width, y: 0)), duration: frameTime),
                    SKAction.runBlock({self.images[0].position = self.getPosition(CGPoint(x: -self.screenSize.width * 2,y: 0))}),
                    SKAction.moveTo(getPosition(CGPoint(x: 0, y: 0)), duration: frameTime * 2)
                    ])
                ))
            
            /* BG 2 */
            images[1].position = getPosition(CGPoint(x: -screenSize.width,y: 0))
            images[1].runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.moveTo(getPosition(CGPoint(x: screenSize.width, y: 0)), duration: frameTime * 2),
                    SKAction.runBlock({self.images[1].position = self.getPosition(CGPoint(x: -self.screenSize.width * 2,y: 0))}),
                    SKAction.moveTo(getPosition(CGPoint(x: -screenSize.width, y: 0)), duration: frameTime)
                    ])
                ))
            
            /* BG 3 */
            images[2].position = getPosition(CGPoint(x: -screenSize.width * 2,y: 0))
            images[2].runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.moveTo(getPosition(CGPoint(x: screenSize.width, y: 0)), duration: frameTime * 3),
                    SKAction.runBlock({self.images[2].position = self.getPosition(CGPoint(x: -self.screenSize.width * 2,y: 0))})
                    ])
                ))
        }
        
        self.addChild(images[0])
        self.addChild(images[1])
        self.addChild(images[2])
    }

    required public init?(coder aDecoder: NSCoder) {
        self.screenSize = CGSize(width: 0,height: 0)
        super.init(coder: aDecoder)
    }
    
    private func getPosition(point : CGPoint) -> CGPoint {
        return CGPoint(x: point.x + (screenSize.width / 2), y: point.y + (screenSize.height / 2))
    }
    
    public func stop(){
        for image : SKSpriteNode in images {
            image.removeAllActions()
        }
    }
}
