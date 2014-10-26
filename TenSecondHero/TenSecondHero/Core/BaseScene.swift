//
//  BaseScene.swift
//  TenSecondHero
//
//  Created by pucpr on 25/10/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class BaseScene : SKNode {
    internal var musicAction : SKAction = SKAction()
    
    override public init() {
        super.init()
        musicAction = SKAction.playSoundFileNamed("WeDontNeedAHero.aifc", waitForCompletion: false)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func onStartScene() {
        runAction(musicAction)
    }
}
