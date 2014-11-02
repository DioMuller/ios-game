//
//  MainGame.swift
//  TenSecondHero
//
//  Created by pucpr on 25/10/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//


import SpriteKit

protocol GameDelegate {
    func gameOver(level : Int, score : Int)
}

class GameScene : SKScene, SKPhysicsContactDelegate {

    // Current Scene displayed
    var currentScene : BaseScene = BaseScene()
    
    // GUI Items
    var scoreText : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    var countdownText : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    var heroName : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    var heroImage : SKSpriteNode = SKSpriteNode()
    
    // Game State Helpers
    var score : Int = 0
    var nextLevel : Int = -1
    private var countdownTimer : Int = 0
    private var levelEnded : Bool = false
    
    private var lives : Int = 3
    
    private var infiniteMode : Bool = false
    
    var gameDelegate : GameDelegate?
    
    // Countdown Property
    var countdown : Int {
        get { return countdownTimer }
        set( value ) {
            countdownTimer = value
            
            if( countdownTimer > 5 ) {
                countdownText.fontColor = UIColor.whiteColor()
                countdownText.fontSize = 32
                countdownText.removeAllActions()
            } else if ( countdownTimer > 3 ) {
                countdownText.fontColor = UIColor.yellowColor()
                countdownText.fontSize = 46
                countdownText.removeAllActions()
            } else {
                countdownText.fontColor = UIColor.redColor()
                countdownText.fontSize = 62
                
                if( !countdownText.hasActions() ) {
                    countdownText.runAction(SKAction.repeatActionForever(
                        SKAction.sequence([
                                SKAction.scaleTo(1.5, duration: 0.3),
                                SKAction.scaleTo(1.0, duration: 0.3)
                            ])
                        ))
                }
            }
            
            countdownText.text = "\(countdownTimer)"
        }
    }
    
    override init(size : CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        /* Countdown Text */
        countdownText.text = "\(countdownTimer)"
        countdownText.position = CGPoint(x: self.frame.width - 40, y: 20)
        countdownText.fontColor = UIColor.redColor()
        self.addChild(countdownText)
        
        /* Hero Name */
        heroName.text = "Hero"
        heroName.position = CGPoint(x: self.frame.width - 100, y: 20)
        heroName.fontColor = UIColor(red: 1, green: 0.5, blue: 0.25, alpha: 1)
        heroName.fontSize = 24
        self.addChild(heroName)
        
        if( nextLevel == -1 ) {
            /* Level Selection Loop */
            goToNextLevel()
        } else {
            /* Play Level on Infinite Mode */
            infiniteModeAtLevel(nextLevel)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if(!levelEnded) { currentScene.touchesBegan(touches, withEvent: event) }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if(!levelEnded) { currentScene.touchesMoved(touches, withEvent: event) }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if(!levelEnded) { currentScene.touchesEnded(touches, withEvent: event) }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        if(!levelEnded) { currentScene.touchesCancelled(touches, withEvent: event) }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if(!levelEnded) { currentScene.didBeginContact(contact) }
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
            case Minigames.Space:
                currentScene = SpaceScene()
                break
            case Minigames.Run:
                currentScene = RunningScene()
                break
            case Minigames.Shoot:
                currentScene = ShooterScene()
            default:
                chooseNext()
                loadNext()
        }
        
        addChild(currentScene)
        currentScene.onStartScene()
        
        prepareGameGUI()
    }
    
    func chooseNext() {
        var x : Int = nextLevel
        
        // Guarantees no repeats
        while ( x == nextLevel ) {
            x = random() % Minigames.Count
        }
        
        nextLevel = x
    }
    
    func cleanGUI(){
        scoreText.removeFromParent()
        countdownText.removeFromParent()
        heroImage.removeFromParent()
        heroName.removeFromParent()
    }
    
    func prepareGameGUI(){
        self.addChild(scoreText)
        if( !infiniteMode ) { self.addChild(countdownText) }
    }
    
    func prepareTransitionGUI(){
        self.addChild(scoreText)
        
        var hero : HeroInfo = Minigames.getInfo(nextLevel).hero
        
        heroName.text = hero.name
        
        /* Hero Image */
        heroImage = SKSpriteNode(imageNamed: hero.image)
        heroImage.position = CGPoint(x: self.frame.width - 100, y: 50)
        
        self.addChild(heroName)
        self.addChild(heroImage)
    }
    
    func endLevel() {
        if( !levelEnded ){
            levelEnded = true
            
            if( infiniteMode ) {
                endGame( nextLevel )
            } else {
                removeAllActions()
                
                lives = lives - 1

                if( lives >= 0 ) {
                    runAction(SKAction.sequence([
                            SKAction.waitForDuration(1),
                            SKAction.runBlock(goToNextLevel)
                        ]))
                } else {
                    endGame(Minigames.MainGame)
                }
            }
        }
    }
    
    func endGame(gameType: Int) {
        
        nextLevel = gameType

        var action : SKAction = SKAction.sequence([
            SKAction.waitForDuration(1.0),
            SKAction.runBlock(goToGameOver)
            ])
        
        runAction(action)
    }
    
    func goToGameOver() {
        self.gameDelegate?.gameOver(self.nextLevel, score: self.score)
    }
    
    func goToNextLevel() {
        levelEnded = false
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
    
    func infiniteModeAtLevel(level : Int) {
        nextLevel = level
        infiniteMode = true
        levelEnded = false
        
        runAction(SKAction.sequence([
            SKAction.runBlock(loadTransition),
            SKAction.waitForDuration(3.0),
            SKAction.runBlock(loadNext)
            ]))
    }
    
}
