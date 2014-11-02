//
//  AnimationHelper.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 11/2/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class Animation {
    public class func generateTextures(imageNamed : String, xOffset : CGFloat, yOffset : CGFloat ) -> [SKTexture] {
        var mainTexture : SKTexture = SKTexture(imageNamed: imageNamed)
        var textures : [SKTexture] = []
    
        for( var i : CGFloat = 0; i < 1.0; i = i + xOffset ) {
            for( var j : CGFloat = 0; j < 1.0; j = j + yOffset ){
                textures.append(SKTexture(rect: CGRect(x: i, y: j, width: xOffset, height: yOffset), inTexture: mainTexture))
            }
        }
    
        return textures
    }
}
