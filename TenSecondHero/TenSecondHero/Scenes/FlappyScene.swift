//
//  TestScene.swift
//  TenSecondHero
//
//  Created by pucpr on 25/10/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

public class FlappyScene : BaseScene {
    var hero : FlappyHero = FlappyHero()
    var background : ParallaxBackground = ParallaxBackground()
    
    override init() {
        super.init()        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func onStartScene() {
        super.onStartScene()
        hero.position = CGPoint(x: 100, y: 100)
        addChild(hero)
        
        background = ParallaxBackground(imageNamed: "background_city01.png", size: self.scene!.size, velocity: 0.1)
        addChild(background)
    }
    
    public override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        hero.touchesBegan(touches, withEvent: event)
    }
}