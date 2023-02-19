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
    
    // STARTING POINT
    let startingPoint = CGPoint(x: GameParameters.frameWidth/2, y: GameParameters.frameHeight/2)
    
    // NODE IMAGE NAMES
    let playerImageName = "player"
    let groundImageName = "rampa"
    
    // NODES
    let cameraNode = SKCameraNode()
    var playerNode: SKSpriteNode!
    var backgroundNode: SKSpriteNode!
    var groundNode: SKSpriteNode!
    
    // BOOL CHECKS
    var isOnGround = true
    
    let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        
        addBackground()
        addGround()
        addPlayer()
        addCamera()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        physicsWorld.gravity = MechanicsController.applyGravity(motionManager: motionManager)
        MechanicsController.fixCamera(cameraNode: cameraNode, playerNode: playerNode)
        MechanicsController.reposition(player: playerNode, ground: groundNode, scene: self)
    }
    
    func addPlayer() {
        
        let playerTexture = SKTexture(imageNamed: playerImageName)
        
        playerNode = SKSpriteNode(texture: playerTexture)
        playerNode.size = CGSize(width: 100, height: 100)
        playerNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        playerNode.physicsBody = SKPhysicsBody(texture: playerTexture, size: playerNode.size)
        playerNode.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        playerNode.physicsBody?.collisionBitMask = PhysicsCategory.groundCategory
        groundNode.physicsBody?.contactTestBitMask = PhysicsCategory.groundCategory
        
        playerNode.physicsBody?.mass = GameParameters.playerMass
        playerNode.physicsBody?.friction = GameParameters.stdFriction
        
        playerNode.physicsBody?.affectedByGravity = true
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
        let groundTexture = SKTexture(imageNamed: groundImageName)
        
        groundNode = SKSpriteNode(texture: groundTexture)
        groundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        groundNode.setScale(2)
        
        groundNode.physicsBody = SKPhysicsBody(texture: groundTexture, size: groundNode.size)
        groundNode.physicsBody?.categoryBitMask = PhysicsCategory.groundCategory
        groundNode.physicsBody?.collisionBitMask = PhysicsCategory.playerCategory
        groundNode.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
        
        groundNode.physicsBody?.mass = GameParameters.staticObjMass
        groundNode.physicsBody?.friction = GameParameters.stdFriction
        
        groundNode.physicsBody?.isDynamic = true
        groundNode.physicsBody?.allowsRotation = false
        groundNode.physicsBody?.pinned = true
        
        groundNode.name = "ground"
        addChild(groundNode)
    }
    
    func addBackground() {
        backgroundNode = SKSpriteNode(imageNamed: "background")
        backgroundNode.size = CGSize(width: scene!.frame.width, height: scene!.frame.height)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundNode.zPosition = -1
        
        addChild(backgroundNode)
    }
    
}
