//
//  NikoLevel1.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 02/03/23.
//

import SpriteKit
import GameplayKit
import CoreMotion
import AVFoundation

class NikoLevel1: SKScene {
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
    
    // BOOL CHECKS
    var isOnGround = true
    
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
        
        playerNode = childNode(withName: "circle")
        PhysicsController.setupNode(node: playerNode, nodeSelfCategory: PhysicsCategory.player, nodeCollisionCategory: PhysicsCategory.ground|PhysicsCategory.fatuum)
        
//        tokenNode = childNode(withName: "token")
//        PhysicsController.setupNode(node: tokenNode, nodeSelfCategory: PhysicsCategory.token, nodeCollisionCategory: PhysicsCategory.player)
        
//        fatuumParentNode = childNode(withName: "fatuum")
//        PhysicsController.setupNode(node: fatuumParentNode, nodeSelfCategory: PhysicsCategory.fatuum, nodeCollisionCategory: PhysicsCategory.player)
        
        
        self.camera = childNode(withName: "camera") as? SKCameraNode
        spawnPoint = playerNode.position
        addScore()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        scoreNode.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y + 70)
        physicsWorld.gravity = MechanicsController.getTiltedGravityVector(motionManager: motionManager)
        MechanicsController.fixCamera(cameraNode: self.camera!, node: childNode(withName: "circle")!)
    }
    
    func addScore() {
        scoreNode.text = "\(points)"
        scoreNode.fontName = "Fatuito"
        scoreNode.fontSize = GameParameters.fontSize/5
        scoreNode.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y + 100)
        
        scoreNode.name = "score"
        addChild(scoreNode)
    }
}

extension NikoLevel1: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        checkCollision(contact: contact)
    }
    
    func checkCollision(contact: SKPhysicsContact) {
        if contact.bodyA.node == playerNode {
            if contact.bodyB.node?.parent == groundParentNode {
                contactPlayerGround()
            }
            if contact.bodyB.node?.parent == tokenNode {
                contactPlayerToken()
            }
            if contact.bodyB.node?.name == "fatuum" {
                contactPlayerFatuum(fatuumParentNode: contact.bodyB.node!)
            }
        } else if contact.bodyB.node == playerNode {
            if contact.bodyA.node?.parent == groundParentNode {
                contactPlayerGround()
            }
            if contact.bodyA.node?.parent == tokenNode {
                contactPlayerToken()
            }
            if contact.bodyA.node?.name == "fatuum" {
                contactPlayerFatuum(fatuumParentNode: contact.bodyA.node!)
            }
        }
    }
    
    func contactPlayerGround() {
        isOnGround = true
    }
    
    func contactPlayerToken() {
        if points >= minPoints {
            GameParameters.isWon = true
        } else {
            GameParameters.isWon = false
        }
        GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
    }
    
    func contactPlayerFatuum(fatuumParentNode: SKNode) {
        fatuumParentNode.removeFromParent()
        scoreNode.removeFromParent()
        points = MechanicsController.addPoint(actualPoints: points)
        addScore()
    }
}


extension NikoLevel1 {
    
    func touchDown(atPoint pos : CGPoint) {
//        print("touchDown")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        print("touchMoved")
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        print("touchUp")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesBegan")
        if isOnGround {
            MechanicsController.jump(node: playerNode, motionManager: motionManager)
            isOnGround = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesMoved")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesEnded")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesCancelled")
    }
    
}
