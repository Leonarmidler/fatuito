//
//  LevelCreator.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 03/03/23.
//

import SpriteKit
import GameplayKit
import CoreMotion
import AVFoundation

class LevelCreator: SKScene {
    // LEVEL PARAMETER
    static var minScore = Int()
    static var bgSound = AVAudioPlayer()
    
    // SCORE PARAMETERS
    var score: Int = 0
    
    // STARTING POINT
    var spawnPoint = CGPoint()
    
    // NODES
    var playerNode: SKNode!
    var groundParentNode: SKNode!
    var fatuumParentNode: SKNode!
    var tokenNode: SKNode!
//    var phoneNode: SKNode!
    var scoreNode = SKLabelNode()
    var menuNode = SKLabelNode()
    
    // BOOL CHECKS
    var shouldUpdate = true
    var canJump = true
    
    // MOTION MANAGER
    let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        // THINGS TO DO IN EVERY START OF LEVELS
        GameParameters.isWon = false
        motionManager.startAccelerometerUpdates()
        physicsWorld.contactDelegate = self
        AudioController.playSoundForever(audioPlayer: AudioController.gulaguForest)
        // END
        
        groundParentNode = childNode(withName: "ground")
        PhysicsController.setupNode(node: groundParentNode, nodeSelfCategory: PhysicsCategory.ground, nodeCollisionCategory: PhysicsCategory.player)
        
        playerNode = childNode(withName: "player")
        PhysicsController.setupNode(node: playerNode, nodeSelfCategory: PhysicsCategory.player, nodeCollisionCategory: PhysicsCategory.ground|PhysicsCategory.fatuum)
        
        tokenNode = childNode(withName: "token")
        PhysicsController.setupNode(node: tokenNode, nodeSelfCategory: PhysicsCategory.token, nodeCollisionCategory: PhysicsCategory.player)
        
        fatuumParentNode = childNode(withName: "fatuum")
        //        PhysicsController.setupNode(node: fatuumParentNode, nodeSelfCategory: PhysicsCategory.fatuum, nodeCollisionCategory: PhysicsCategory.ground)
        //        AnimationController.animateFatuum(fatuum: childNode(withName: "fatuum")!.parent!)
        
        self.camera = childNode(withName: "camera") as? SKCameraNode
        spawnPoint = playerNode.position
        addMenu()
        addScore()
        addPhone()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if shouldUpdate {
            //FIX CAMERA
            UpdateController.fixCamera(cameraNode: self.camera!, playerNode: childNode(withName: "player")!, wallParentNode: childNode(withName: "wall")!)
            
            // FIX FRAME POSITION WITH THE CAMERA
            //            UpdateController.fixFramePosition(playerNode: playerNode, menuNode: menuNode, scoreNode: scoreNode)
            
            // FIX GRAVITY
            physicsWorld.gravity = MechanicsController.getTiltedGravityVector(motionManager: motionManager)
            
            checkCollision()
        }
    }
    
    func addMenu() {
        menuNode.text = "| |"
        menuNode.fontName = "Fatuito"
        menuNode.fontSize = GameParameters.inGameFontSize
        
        menuNode.position = CGPoint(x: GameParameters.menuButtonOffsetX(playerNode: playerNode), y: GameParameters.menuButtonOffsetY(playerNode: playerNode))
        menuNode.zPosition = 5
        
        menuNode.name = "menu"
        self.camera!.addChild(menuNode)
    }
    
    func addScore() {
        scoreNode.text = "\(score)"
        scoreNode.fontName = "Fatuito"
        scoreNode.fontSize = GameParameters.inGameFontSize
        
        scoreNode.position = CGPoint(x: GameParameters.scoreOffsetX(playerNode: playerNode) , y: GameParameters.scoreOffsetY(playerNode: playerNode))
        scoreNode.zPosition = 5
    
        scoreNode.name = "score"
        self.camera!.addChild(scoreNode)
    }
    
    func addPhone() {
        let phoneNode = SKSpriteNode(imageNamed: "phoneTilt")
        phoneNode.position = CGPoint(x: frame.midX, y: frame.midY - 140)
        phoneNode.setScale(0.3)
        phoneNode.zPosition = 5
        phoneNode.alpha = 0.5
        
        self.camera!.addChild(phoneNode)
        AnimationController.phoneRotate(phoneNode: phoneNode)
    }
    
}
