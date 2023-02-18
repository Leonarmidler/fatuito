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

class GameScene: SKScene {
    
    // PARAMETERS
    let cameraFixedX: CGFloat = 150
    let cameraFixedY: CGFloat = 30
    
    let zoomScale: CGFloat = 2.0
    let playerMass: CGFloat = 0.5
    let staticObjMass: CGFloat = 1000
    let stdFriction: CGFloat = 0.5
    
    // NODES
    let cameraNode = SKCameraNode()
    var playerNode: SKSpriteNode!
    var backgroundNode: SKSpriteNode!
    var groundNode: SKSpriteNode!
    
    let motionManager = CMMotionManager()
    
    // CHECKS
    var isOnGround = true
    
    override func didMove(to view: SKView) {
        addCamera()
        addGround()
        addPlayer()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        moveCamera(cameraNode: cameraNode)
        applyGravity(node: playerNode)
    }
    
    func addPlayer() {
        
        playerNode = SKSpriteNode(imageNamed: "player")
        playerNode.size = CGSize(width: 100, height: 100)
        playerNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        playerNode.physicsBody = SKPhysicsBody(texture: SKTexture(image: UIImage(named: "player")!), size: playerNode.size)
        playerNode.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        playerNode.physicsBody?.collisionBitMask = PhysicsCategory.groundCategory
        
        playerNode.physicsBody?.mass = playerMass
        playerNode.physicsBody?.friction = stdFriction
        
        playerNode.physicsBody?.isDynamic = true
        playerNode.physicsBody?.allowsRotation = true
        
        playerNode.name = "player"
        addChild(playerNode)
    }
    
    func addCamera() {
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(cameraNode)
        self.camera = cameraNode
    }
    
    func addGround() {
        groundNode = SKSpriteNode(imageNamed: "rampa")
        groundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        groundNode.physicsBody = SKPhysicsBody(texture: SKTexture(image: UIImage(named: "rampa")!), size: groundNode.size)
        groundNode.physicsBody?.categoryBitMask = PhysicsCategory.groundCategory
        groundNode.physicsBody?.collisionBitMask = PhysicsCategory.playerCategory
        
        groundNode.physicsBody?.mass = staticObjMass
        groundNode.physicsBody?.friction = stdFriction
        
        groundNode.physicsBody?.isDynamic = true
        groundNode.physicsBody?.allowsRotation = false
        groundNode.physicsBody?.pinned = true
        
        groundNode.name = "ground"
        addChild(groundNode)
    }
    
    func addBackground() {
        backgroundNode = SKSpriteNode(imageNamed: "background")
        backgroundNode.size = CGSize(width: self.view!.frame.width, height: self.view!.frame.height)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(backgroundNode)
    }
    
}
