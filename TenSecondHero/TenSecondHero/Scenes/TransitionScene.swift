//
//  TransitionScene.swift
//  TenSecondHero
//
//  Created by pucpr on 01/11/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class TransitionScene : BaseScene {
    var text : String = String()
    var size : CGSize = CGSize()
    
    var messageText : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    init(message : String) {
        super.init()
        self.text = message
        self.size = self.scene!.size
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func onStartScene() {
        super.onStartScene()
        
        size = self.scene!.size
    }
    
    public override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

    }
    
    override func didBeginContact(contact: SKPhysicsContact) {

    }
}