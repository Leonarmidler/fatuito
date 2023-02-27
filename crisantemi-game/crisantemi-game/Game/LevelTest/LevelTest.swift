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

class LevelTest: SKScene {
    
    // STARTING POINT
    var spawnPoint = CGPoint()
    
    // NODES
    var playerNode = SKNode()
    var circleNode = SKNode()
    
    // BOOL CHECKS
    var isOnGround = true
    
    // MOTION MANAGER
    let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        physicsWorld.contactDelegate = self
        
        playerNode = childNode(withName: "player")!
        circleNode = childNode(withName: "circle")!
        self.camera = childNode(withName: "camera") as? SKCameraNode

        spawnPoint = playerNode.position
        
        // CREATING THE JOINT BETWEEN THE INTERN AND THE EXTERN
        physicsWorld.add(MechanicsController.setDynamicAnchorPoint(firstNode: circleNode, secondNode: playerNode, anchorPoint: CGPoint(x: circleNode.frame.midX, y: circleNode.frame.midY), damping: 0.5, frequency: 0.9))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        physicsWorld.gravity = MechanicsController.getTiltedGravityVector(motionManager: motionManager)
        MechanicsController.fixCamera(cameraNode: self.camera!, playerNode: circleNode)
        
//        MechanicsController.reposition(nodeToReposition: circleNode, playerNode: playerNode, refNode: groundNode, spawnPoint: startingPoint)
    }

    
}
