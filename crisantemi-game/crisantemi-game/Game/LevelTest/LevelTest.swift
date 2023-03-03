//
//  GameScene.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 15/02/23.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreMotion
import AVFoundation

class LevelTest: SKScene {
    // POINT PARAMETERS
    let minPoints: Int = 3
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
        
        fatuumParentNode = childNode(withName: "fatuum")
        PhysicsController.setupNode(node: fatuumParentNode, nodeSelfCategory: PhysicsCategory.fatuum, nodeCollisionCategory: PhysicsCategory.player)
        
//        playerNode = childNode(withName: "player")!
//        PhysicsController.setupNode(node: childNode(withName: "player")!, nodeSelfCategory: PhysicsCategory.playerCategory, nodeCollisionCategory: PhysicsCategory.groundCategory)
        
        self.camera = childNode(withName: "camera") as? SKCameraNode
        spawnPoint = playerNode.position
        addScore()
        addMenu()
        
        // CREATING THE JOINT BETWEEN THE INTERN AND THE EXTERN
//        physicsWorld.add(MechanicsController.createJoint(firstNode: childNode(withName: "circle")!, secondNode: childNode(withName: "player")!, anchorPoint: CGPoint(x: childNode(withName: "player")!.frame.midX, y: childNode(withName: "player")!.frame.midY), damping: 0.5, frequency: 0.9))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if shouldUpdate {
            //FIX CAMERA
            UpdateController.fixCamera(cameraNode: self.camera!, playerNode: playerNode)
            
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
        
        scoreNode.name = "score"
        addChild(scoreNode)
    }
    
    func addMenu() {
        menuNode.text = "I I"
        menuNode.fontName = "Fatuito"
        menuNode.fontSize = GameParameters.inGameFontSize
        
        menuNode.name = "menu"
        addChild(menuNode)
    }
    
    
}
