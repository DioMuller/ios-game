//
//  MainGame.swift
//  TenSecondHero
//
//  Created by pucpr on 25/10/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

struct HeroInfo {
    var name : String = String()
    var image : String = String()
    
    init(name : String, image : String){
        self.name = name
        self.image = image
    }
}

struct MinigameInfo {
    var title : String
    var hero : HeroInfo
    
    init(title : String, hero : HeroInfo){
        self.title = title
        self.hero = hero
    }
}

struct Minigames {
    static var Flap : Int = 0
    static var Shoot : Int = 1
    static var Run : Int = 2
    
    static var Count = 3
    
    static func getInfo(type : Int ) -> MinigameInfo {
        switch(type) {
            case Flap:
                return MinigameInfo(title: "Flap!", hero: HeroInfo(name: "Flying Hero", image: "10sechero.png"))
            case Shoot:
                return MinigameInfo(title: "Shoot!", hero: HeroInfo(name: "Space Hero", image: "10sechero.png"))
            case Run:
                return MinigameInfo(title: "Run!", hero: HeroInfo(name: "Running Hero", image: "strongman01.png"))
            default:
                return MinigameInfo(title: "Error!", hero: HeroInfo(name: "Wrong Hero", image: "hero_failure.png"))
        }
    }
}

class GameScene : SKScene, SKPhysicsContactDelegate {
    // Current Scene displayed
    var currentScene : BaseScene = BaseScene()
    
    // GUI Items
    var scoreText : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    var countdownText : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    // Game State Helpers
    var score : Int = 0
    var nextLevel : Int = 0
    private var countdownTimer : Int = 0
    
    
    // Countdown Property
    var countdown : Int {
        get { return countdownTimer }
        set( value ) {
            countdownTimer = value
            
            if( countdownTimer > 5 ) {
                countdownText.fontColor = UIColor.whiteColor()
                countdownText.fontSize = 32
            } else if ( countdownTimer > 3 ) {
                countdownText.fontColor = UIColor.yellowColor()
                countdownText.fontSize = 46
            } else {
                countdownText.fontColor = UIColor.redColor()
                countdownText.fontSize = 62
            }
            
            countdownText.text = "\(countdownTimer)"
        }
    }
    
    override func didMoveToView(view: SKView) {
        
        currentScene.onStartScene()
        
        /* World Physics */
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = Collisions.Level
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        
        /* Score Text */
        scoreText.text = "Score: \(score)"
        scoreText.position = CGPoint(x: 100, y: 20)
        scoreText.fontColor = UIColor.redColor()
        self.addChild(scoreText)
        
        /* Score Text */
        countdownText.text = "\(countdownTimer)"
        countdownText.position = CGPoint(x: self.frame.width - 40, y: 20)
        countdownText.fontColor = UIColor.redColor()
        self.addChild(countdownText)
        
        /* Level Selection Loop */
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock({
                self.chooseNext()
                self.loadTransition()
            }),
            SKAction.waitForDuration(3.0),
            SKAction.runBlock({self.loadNext()}),
            SKAction.runBlock({self.countdown = 10}),
            SKAction.group([
                SKAction.waitForDuration(10.0),
                SKAction.repeatAction(
                    SKAction.sequence([
                        SKAction.waitForDuration(1.0),
                        SKAction.runBlock({self.countdown = self.countdown - 1})
                    ]), count: 10)
            ])
        ])))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        currentScene.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        currentScene.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        currentScene.touchesEnded(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        currentScene.touchesCancelled(touches, withEvent: event)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        currentScene.didBeginContact(contact)
    }
    
    func addScore(points : Int) {
        score += points
        scoreText.text = "Score: \(score)"
    }
    
    func loadTransition() {
        currentScene.removeFromParent()
        cleanGUI()
        
        var gameInfo = Minigames.getInfo(nextLevel)
        
        currentScene = TransitionScene(message: gameInfo.title)
        
        addChild(currentScene)
        currentScene.onStartScene()
        prepareTransitionGUI()
    }
    
    func loadNext(){
        
        currentScene.removeFromParent()
        cleanGUI()
        
        switch(nextLevel) {
            case Minigames.Flap:
                currentScene = FlappyScene()
                break
            case Minigames.Shoot:
                currentScene = ShootingScene()
                break
            case Minigames.Run:
                currentScene = RunningScene()
                break
            default:
                chooseNext()
                loadNext()
        }
        
        addChild(currentScene)
        currentScene.onStartScene()
        
        prepareGameGUI()
    }
    
    func chooseNext() {
        nextLevel = random() % Minigames.Count
    }
    
    func cleanGUI(){
        scoreText.removeFromParent()
        countdownText.removeFromParent()
    }
    
    func prepareGameGUI(){
        self.addChild(scoreText)
        self.addChild(countdownText)
    }
    
    func prepareTransitionGUI(){
        self.addChild(scoreText)
    }
    
}
