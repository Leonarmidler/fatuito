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
    let startingPoint = CGPoint(x: -GameParameters.frameWidth/2+10, y: GameParameters.frameHeight/2+50)
    
    // NODE IMAGE NAMES
    let playerImageName = "fatuumInt"
    let circleImage = "fatuumExt"
    let eyesImage = "fatuumEyes"
    let groundImageName = "stageTest"
    
    // NODES
    let cameraNode = SKCameraNode()
    var playerNode: SKSpriteNode!
    var backgroundNode: SKSpriteNode!
    var groundNode: SKSpriteNode!
    var circleNode: SKSpriteNode!
    var eyesNode: SKSpriteNode!
    
    // BOOL CHECKS
    var isOnGround = true
    let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        physicsWorld.contactDelegate = self
        
        addBackground()
        addGround(name: "levelTest", position: CGPoint(x: 0, y: 0))
        addPlayer()
        addExtCircle()
        addCamera()

        let anchorPointPlayer = CGPoint(x: circleNode.frame.midX, y: circleNode.frame.midY)
        
        physicsWorld.add(MechanicsController.setDynamicAnchorPoint(firstNode: circleNode, secondNode: playerNode, anchorPoint: anchorPointPlayer, damping: 0.5, frequency: 0.9))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        physicsWorld.gravity = MechanicsController.applyGravity(motionManager: motionManager)
        backgroundNode.position = circleNode.position
        MechanicsController.fixCamera(cameraNode: cameraNode, playerNode: circleNode)
        MechanicsController.reposition(nodeToReposition: circleNode, playerNode: playerNode, refNode: groundNode, spawnPoint: startingPoint)
    }
    
    func addCamera() {
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(cameraNode)
        self.camera = cameraNode
    }
    
    func addExtCircle() {
        let circleTexture = SKTexture(imageNamed: circleImage)
        
        circleNode = SKSpriteNode(texture: circleTexture)
        circleNode.size = GameParameters.circleSize
        circleNode.position = startingPoint
        
        circleNode.physicsBody = SKPhysicsBody(circleOfRadius: GameParameters.circleSize.height/2)
        
        circleNode.physicsBody?.categoryBitMask = PhysicsCategory.circleCategory
        circleNode.physicsBody?.collisionBitMask = PhysicsCategory.groundCategory
        circleNode.physicsBody?.contactTestBitMask = PhysicsCategory.groundCategory
        
        circleNode.physicsBody?.mass = GameParameters.playerMass
        circleNode.physicsBody?.friction = GameParameters.stdFriction
        
        circleNode.physicsBody?.affectedByGravity = true
        circleNode.physicsBody?.isDynamic = true
        circleNode.physicsBody?.allowsRotation = true
        
        addChild(circleNode)
    }
    
    func addPlayer() {
        let playerTexture = SKTexture(imageNamed: playerImageName)
        
        playerNode = SKSpriteNode(texture: playerTexture)
        playerNode.size = GameParameters.playerSize
        playerNode.position = startingPoint
        
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: GameParameters.playerSize.width/2)
        
        playerNode.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        playerNode.physicsBody?.collisionBitMask = PhysicsCategory.groundCategory
        playerNode.physicsBody?.contactTestBitMask = PhysicsCategory.groundCategory
            
        playerNode.physicsBody?.mass = GameParameters.playerMass/10
        playerNode.physicsBody?.friction = GameParameters.stdFriction
        
        playerNode.physicsBody?.affectedByGravity = true
        playerNode.physicsBody?.isDynamic = true
        playerNode.physicsBody?.allowsRotation = false
    
        addChild(playerNode)
    }
    
    func addGround(name: String, position: CGPoint) {
        let groundTexture = SKTexture(imageNamed: name)
        
        groundNode = SKSpriteNode(texture: groundTexture)
        groundNode.position = position
        
        groundNode.physicsBody = SKPhysicsBody(texture: groundTexture, size: groundNode.size)

        groundNode.physicsBody?.categoryBitMask = PhysicsCategory.groundCategory
        groundNode.physicsBody?.collisionBitMask = PhysicsCategory.playerCategory
        groundNode.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
        
        groundNode.physicsBody?.mass = GameParameters.staticObjMass
        groundNode.physicsBody?.friction = GameParameters.stdFriction
        
        groundNode.physicsBody?.isDynamic = false
        groundNode.physicsBody?.allowsRotation = false
        groundNode.physicsBody?.pinned = true
        
        groundNode.name = "ground"
        addChild(groundNode)
    }
    
    func addBackground() {
        backgroundNode = SKSpriteNode(imageNamed: "background")
        backgroundNode.size = CGSize(width: GameParameters.frameWidth, height: GameParameters.frameHeight)
        backgroundNode.zPosition = -5
        
        backgroundNode.setScale(0.1)
        
        addChild(backgroundNode)
    }
    
}
