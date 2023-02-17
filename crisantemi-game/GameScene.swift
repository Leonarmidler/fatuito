//
//  GameScene.swift
//  game-test
//
//  Created by Leonardo Daniele on 15/02/23.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreMotion

struct PhysicsCategory {
    static let none   : UInt32 = 0
    static let playerCategory : UInt32 = 0b1
    static let groundCategory : UInt32 = 0b10
}


class GameScene: SKScene {
    
    // VARIABILI
    private let cameraDistanceX: CGFloat = 150
    private let cameraDistanceY: CGFloat = 30
    private let zoomScale: CGFloat = 2.0
    
    private let playerMass: CGFloat = 0.5
    
    private var playerNode: SKSpriteNode!
    private var backgroundNode: SKSpriteNode!
    private var groundNode: SKSpriteNode!
    private let motionManager = CMMotionManager()
    
    var isOnGround = true
    var moveCameraUp = false
    var moveCameraDown = false
    var moveCameraRight = false
    var moveCameraLeft = false
    
    let cameraNode = SKCameraNode()
    
    override func didMove(to view: SKView) {
        // TEST
        // --
        
        addCamera()
        addGround()
        addPlayer()
        
    }
    
    func addPlayer() {
        
        playerNode = SKSpriteNode(imageNamed: "player")
        playerNode.size = CGSize(width: 100, height: 100)
        playerNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        playerNode.physicsBody = SKPhysicsBody(texture: SKTexture(image: UIImage(named: "player")!), size: playerNode.size)
        playerNode.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        playerNode.physicsBody?.collisionBitMask = PhysicsCategory.groundCategory
        
        playerNode.physicsBody?.mass = playerMass
        playerNode.physicsBody?.friction = 0.5
        
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
        //        groundNode.size = CGSize(width: CGFloat(5000), height: groundNode.frame.height)
        groundNode.position = CGPoint(x: frame.midX, y: CGFloat(frame.midY - 150))
        
        groundNode.physicsBody = SKPhysicsBody(texture: SKTexture(image: UIImage(named: "rampa")!), size: groundNode.size)
        groundNode.physicsBody?.categoryBitMask = PhysicsCategory.groundCategory
        groundNode.physicsBody?.collisionBitMask = PhysicsCategory.playerCategory
        
        groundNode.physicsBody?.mass = 1000
        groundNode.physicsBody?.friction = 0.5
        
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
    
    func applyGravity(node: SKNode) {
        
        self.motionManager.startAccelerometerUpdates()
        let action = SKAction.run {
            if let accData = self.motionManager.accelerometerData {
                let tilt = self.checkTilt(actualTilt: self.motionManager.accelerometerData!.acceleration.y)
                let gravityForce = CGFloat(-9.8 * self.playerMass)
                let sin = CGFloat(tilt)
                let cos = cos(asin(sin))
                
                let fixedGravity = CGVector(dx: gravityForce*sin, dy: gravityForce*cos)
                self.physicsWorld.gravity = fixedGravity
            }
        }
        
        node.run(action)
        
    }
    
    func checkPosition(node: SKSpriteNode) {
        if (node.position.x > frame.midX + cameraDistanceX) {
            moveCameraRight = true
        } else {
            moveCameraRight = false
        }
        
        if (node.position.x < frame.midX - cameraDistanceX) {
            moveCameraLeft = true
        } else {
            moveCameraLeft = false
        }
    }
    
    func checkTilt(actualTilt: Double) -> Double {
        
        let maxTilt = 0.8
        let minTilt = -maxTilt
        var tilt = actualTilt
        
        if actualTilt >= maxTilt {
            tilt = maxTilt
        } else if actualTilt <= minTilt {
            tilt = minTilt
        }
        
        return tilt
    }
    
    func moveCamera(cameraNode: SKCameraNode) {
        
        cameraNode.position.x = playerNode.position.x
        cameraNode.position.y = playerNode.position.y + cameraDistanceY
        
        cameraNode.setScale(zoomScale)
        
    }
    
    func printAccelerometerData() {
        let tilt = self.checkTilt(actualTilt: self.motionManager.accelerometerData!.acceleration.y)
        let sin = CGFloat(tilt)
        let cos = cos(asin(sin))
        print("SIN: \(sin) COS: \(cos)")
    }
    
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
        print("touchesBegan")
        printAccelerometerData()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        print("touchesMoved")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled")
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        checkPosition(node: playerNode)
        moveCamera(cameraNode: cameraNode)
        applyGravity(node: playerNode)
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "ground" || contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "ground"{
            isOnGround = true
        } else {
            isOnGround = false
        }
    }
    
}
