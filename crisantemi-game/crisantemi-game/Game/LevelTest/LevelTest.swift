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
    
    // BOOL CHECKS
    var isOnGround = true
    
    // MOTION MANAGER
    let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        physicsWorld.contactDelegate = self
        
        GameParameters.setupPlayer(playerNode: childNode(withName: "player")!)
        
//        groundNode = childNode(withName: "ground")!
        PhysicsController.setupNode(node: childNode(withName: "ground")!, nodeSelfCategory: PhysicsCategory.groundCategory, nodeCollisionCategory: PhysicsCategory.playerCategory)
        
//        playerNode = childNode(withName: "player")!
        PhysicsController.setupNode(node: childNode(withName: "player")!, nodeSelfCategory: PhysicsCategory.playerCategory, nodeCollisionCategory: PhysicsCategory.groundCategory)
        
//        circleNode = childNode(withName: "circle")!
        PhysicsController.setupNode(node: childNode(withName: "circle")!, nodeSelfCategory: PhysicsCategory.playerCategory, nodeCollisionCategory: PhysicsCategory.groundCategory)
        
//        treeNode = childNode(withName: "tree")!
//        PhysicsController.setupNode(node: childNode(withName: "tree")!, nodeSelfCategory: PhysicsCategory.wallCategory, nodeCollisionCategory: PhysicsCategory.playerCategory)
        
        
        self.camera = childNode(withName: "camera") as? SKCameraNode
        
        spawnPoint = childNode(withName: "player")!.position
        
        // CREATING THE JOINT BETWEEN THE INTERN AND THE EXTERN
        physicsWorld.add(MechanicsController.setDynamicAnchorPoint(firstNode: childNode(withName: "circle")!, secondNode: childNode(withName: "player")!, anchorPoint: CGPoint(x: childNode(withName: "player")!.frame.midX, y: childNode(withName: "player")!.frame.midY), damping: 0.5, frequency: 0.9))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        physicsWorld.gravity = MechanicsController.getTiltedGravityVector(motionManager: motionManager)
        MechanicsController.fixCamera(cameraNode: self.camera!, node: childNode(withName: "circle")!)
        
        // TEST GAME OVER
//        if (childNode(withName: "player")!.position == CGPoint(x: 1860.009, y: -1004.25)) {
//            GameParameters.switchScene(fromScene: self, toScene: GameOverScene())
//        }
        //        MechanicsController.reposition(nodeToReposition: circleNode, playerNode: playerNode, refNode: groundNode, spawnPoint: startingPoint)
    }
    
}
