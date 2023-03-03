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
    // POINT PARAMETERS
    let minPoints: Int = 14
    var points: Int = 0
    
    // STARTING POINT
    var spawnPoint = CGPoint()
    
    // NODES
    var playerNode: SKNode!
    var groundParentNode: SKNode!
    var fatuumParentNode: SKNode!
    var tokenNode: SKNode!
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
        // END
        
        groundParentNode = childNode(withName: "ground")
        PhysicsController.setupNode(node: groundParentNode, nodeSelfCategory: PhysicsCategory.ground, nodeCollisionCategory: PhysicsCategory.player)
        
        playerNode = childNode(withName: "player")
        PhysicsController.setupNode(node: playerNode, nodeSelfCategory: PhysicsCategory.player, nodeCollisionCategory: PhysicsCategory.ground|PhysicsCategory.fatuum)
        
        tokenNode = childNode(withName: "token")
        PhysicsController.setupNode(node: tokenNode, nodeSelfCategory: PhysicsCategory.token, nodeCollisionCategory: PhysicsCategory.player)
        
        AudioController.playSound(audioPlayer: AudioController.gulaguForest)
//        fatuumParentNode = childNode(withName: "fatuum")
//        PhysicsController.setupNode(node: fatuumParentNode, nodeSelfCategory: PhysicsCategory.fatuum, nodeCollisionCategory: PhysicsCategory.player)
//        AnimationController.animateFatuum(fatuum: childNode(withName: "fatuum")!.parent!)
        
        
        self.camera = childNode(withName: "camera") as? SKCameraNode
        spawnPoint = playerNode.position
        addScore()
        addMenu()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if shouldUpdate {
            //FIX CAMERA
            UpdateController.fixCamera(cameraNode: self.camera!, playerNode: childNode(withName: "player")!)
            
            // FIX FRAME POSITION WITH THE CAMERA
            UpdateController.fixFramePosition(playerNode: playerNode, menuNode: menuNode, scoreNode: scoreNode)
            
            // FIX GRAVITY
            physicsWorld.gravity = MechanicsController.getTiltedGravityVector(motionManager: motionManager)
        }
    }
    
    func addScore() {
        scoreNode.text = "\(points)"
        scoreNode.fontName = "Fatuito"
        scoreNode.fontSize = GameParameters.inGameFontSize
        
        scoreNode.position = CGPoint(x: playerNode.position.x + GameParameters.scoreOffsetX(playerNode: playerNode), y: playerNode.position.y + GameParameters.scoreOffsetY(playerNode: playerNode))
        
        scoreNode.setScale(2)
        scoreNode.name = "score"
        addChild(scoreNode)
    }
    
    func addMenu() {
        menuNode.text = "I I"
        menuNode.fontName = "Fatuito"
        menuNode.fontSize = GameParameters.inGameFontSize
        
        menuNode.setScale(2)
        menuNode.name = "menu"
        addChild(menuNode)
    }
    
}
