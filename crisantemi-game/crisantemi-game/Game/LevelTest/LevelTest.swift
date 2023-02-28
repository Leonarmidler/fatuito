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
    
    // STARTING POINT
    var spawnPoint = CGPoint()
    
    // NODES
    var playerNode = SKNode()
    var circleNode = SKNode()
    var groundNode = SKNode()
    var treeNode = SKNode()
    var jumpSound = AVAudioPlayer()
    
    // BOOL CHECKS
    var isOnGround = true
    
    // MOTION MANAGER
    let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        physicsWorld.contactDelegate = self
        jumpSound = AudioController.setupAudio(fileName: "jump1")
        
        groundNode = childNode(withName: "ground")!
        PhysicsController.setupNode(node: groundNode, nodeSelfCategory: PhysicsCategory.groundCategory, nodeCollisionCategory: PhysicsCategory.playerCategory)
        
        playerNode = childNode(withName: "player")!
        PhysicsController.setupNode(node: playerNode, nodeSelfCategory: PhysicsCategory.playerCategory, nodeCollisionCategory: PhysicsCategory.groundCategory)
        
        circleNode = childNode(withName: "circle")!
        PhysicsController.setupNode(node: playerNode, nodeSelfCategory: PhysicsCategory.playerCategory, nodeCollisionCategory: PhysicsCategory.groundCategory)
        
        treeNode = childNode(withName: "tree")!
        PhysicsController.setupNode(node: treeNode, nodeSelfCategory: PhysicsCategory.wallCategory, nodeCollisionCategory: PhysicsCategory.playerCategory)
        
        
        self.camera = childNode(withName: "camera") as? SKCameraNode
        
        spawnPoint = playerNode.position
        
        // CREATING THE JOINT BETWEEN THE INTERN AND THE EXTERN
        physicsWorld.add(MechanicsController.setDynamicAnchorPoint(firstNode: circleNode, secondNode: playerNode, anchorPoint: CGPoint(x: playerNode.frame.midX, y: playerNode.frame.midY), damping: 0.5, frequency: 0.9))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        physicsWorld.gravity = MechanicsController.getTiltedGravityVector(motionManager: motionManager)
        MechanicsController.fixCamera(cameraNode: self.camera!, playerNode: circleNode)
        
        
        // TEST GAME OVER
//        if (playerNode.position == CGPoint(x: 1860,009, y: -1004,25)) {
//            GameParameters.switchScene(fromScene: self, toScene: GameOverScene())
//        }
        //        MechanicsController.reposition(nodeToReposition: circleNode, playerNode: playerNode, refNode: groundNode, spawnPoint: startingPoint)
    }
    
}
