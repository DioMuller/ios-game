//
//  Hero.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/26/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

class Hero : SKNode {
    var sprite : SKSpriteNode = SKSpriteNode(imageNamed: "10sechero.png")
    
    override init() {
        super.init()
        
        addChild(sprite)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
