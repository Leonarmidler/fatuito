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
    let startingPoint = CGPoint(x: GameParameters.frameWidth/2, y: GameParameters.frameHeight/2)
    
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
    var count = 0
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        physicsWorld.contactDelegate = self
        
        addGround(name: "rampa", position: CGPoint(x: 0, y: 0))
        addPlayer()
        addExtCircle()
        addCamera()

        let anchorPointPlayer = CGPoint(x: circleNode.frame.midX, y: circleNode.frame.midY)
        
        physicsWorld.add(MechanicsController.setDynamicAnchorPoint(firstNode: circleNode, secondNode: playerNode, anchorPoint: anchorPointPlayer, damping: 0.7, frequency: 1))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        physicsWorld.gravity = MechanicsController.applyGravity(motionManager: motionManager)
        MechanicsController.fixCamera(cameraNode: cameraNode, playerNode: circleNode)
        MechanicsController.reposition(player: circleNode, ground: groundNode, scene: self)
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
        circleNode.position = CGPoint(x: 0, y: 500)
        
        circleNode.physicsBody = SKPhysicsBody(texture: circleTexture, size: circleNode.size)
        
        circleNode.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        circleNode.physicsBody?.collisionBitMask = PhysicsCategory.groundCategory
        circleNode.physicsBody?.contactTestBitMask = PhysicsCategory.groundCategory
        
        circleNode.physicsBody?.mass = GameParameters.playerMass
        circleNode.physicsBody?.friction = GameParameters.stdFriction
        
        circleNode.physicsBody?.affectedByGravity = true
        circleNode.physicsBody?.isDynamic = true
        circleNode.physicsBody?.allowsRotation = true
        
        addChild(circleNode)
    }
    
    func addEyes() {
        let eyesTexture = SKTexture(imageNamed: eyesImage)
        
        eyesNode = SKSpriteNode(texture: eyesTexture)
        eyesNode.size = CGSize(width: 50, height: 50)
        eyesNode.position = CGPoint(x: 0, y: 500)
        
        eyesNode.physicsBody = SKPhysicsBody(texture: eyesTexture, size: eyesTexture.size())
        
        eyesNode.physicsBody?.categoryBitMask = PhysicsCategory.groundCategory
        eyesNode.physicsBody?.collisionBitMask = PhysicsCategory.groundCategory
        eyesNode.physicsBody?.contactTestBitMask = PhysicsCategory.groundCategory
            
        eyesNode.physicsBody?.mass = GameParameters.playerMass/2
        eyesNode.physicsBody?.friction = GameParameters.stdFriction
        
        eyesNode.physicsBody?.affectedByGravity = true
        eyesNode.physicsBody?.isDynamic = true
        eyesNode.physicsBody?.allowsRotation = false
    
        addChild(eyesNode)
        
        let anchorX = circleNode.frame.midX+30
        let anchorY = circleNode.frame.midY+30
        
        let anchorPoint = CGPoint(x: anchorX, y: anchorY)
        
        let eyesJoint = SKPhysicsJointSpring.joint(withBodyA: circleNode.physicsBody!, bodyB: playerNode.physicsBody!, anchorA: CGPoint(x: eyesNode.frame.midX, y: eyesNode.frame.midY), anchorB: anchorPoint)
        
        eyesJoint.damping = 0.9
        eyesJoint.frequency = 1

    }
    
    func addPlayer() {
        let playerTexture = SKTexture(imageNamed: playerImageName)
        
        playerNode = SKSpriteNode(texture: playerTexture)
        playerNode.size = GameParameters.playerSize
        playerNode.position = CGPoint(x: 0, y: 500)
        
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: GameParameters.playerSize.width-20)
        
        playerNode.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        playerNode.physicsBody?.collisionBitMask = PhysicsCategory.playerCategory
        playerNode.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
            
        playerNode.physicsBody?.mass = GameParameters.playerMass/2
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
    
    func spawnPlatform(point: CGPoint) {
        let platformNode: SKSpriteNode!
        let platformTexture = SKTexture(imageNamed: "platform")
        
        platformNode = SKSpriteNode(texture: platformTexture)
        platformNode.size = platformTexture.size()
        
        platformNode.position = point
        
        platformNode.physicsBody = SKPhysicsBody(texture: platformTexture, size: platformNode.size)
        platformNode.physicsBody?.categoryBitMask = PhysicsCategory.groundCategory
        platformNode.physicsBody?.collisionBitMask = PhysicsCategory.playerCategory
        platformNode.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
        
        platformNode.physicsBody?.isDynamic = false
        platformNode.physicsBody?.allowsRotation = false
        platformNode.physicsBody?.pinned = true
        
        platformNode.name = "platform"
        addChild(platformNode)
    }
    
    func addBackground() {
        backgroundNode = SKSpriteNode(imageNamed: "background")
        backgroundNode.size = CGSize(width: scene!.frame.width, height: scene!.frame.height)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundNode.zPosition = -1
        
        addChild(backgroundNode)
    }
    
}
