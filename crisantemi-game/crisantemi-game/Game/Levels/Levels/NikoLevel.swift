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

class NikoLevel: SKScene {
    // POINT PARAMETERS
    let minPoints: Int = 0
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
        
        //        fatuumParentNode = childNode(withName: "fatuum")
        //        PhysicsController.setupNode(node: fatuumParentNode, nodeSelfCategory: PhysicsCategory.fatuum, nodeCollisionCategory: PhysicsCategory.player)
        
        
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

extension NikoLevel: SKPhysicsContactDelegate {
    
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
        canJump = true
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


extension NikoLevel {

}
