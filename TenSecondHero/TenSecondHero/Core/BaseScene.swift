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
        AudioManager.playMusic(sceneMusic)
    }
    
    public var sceneMusic : String {
        get { return "WeDontNeedAHero" }
    }
    
    var rootParent : GameScene {
        get {
            return self.parent as GameScene
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func onStartScene() {
        runAction(musicAction)
    }
    
    func update(currentTime: CFTimeInterval) {
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
    }
}
