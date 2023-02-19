//
//  Mechanics.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import UIKit
import SpriteKit
import GameplayKit

extension GameScene {
    
    func getInclination() -> Double {
        self.motionManager.startAccelerometerUpdates()
        var inclination: Double = 0
        
        if self.motionManager.accelerometerData != nil {
            inclination = self.motionManager.accelerometerData!.acceleration.y
        }
        
        return inclination
    }
    
    func getTiltedGravityVector() -> CGVector {
        let tilt = self.checkTilt(actualTilt: self.getInclination())
        let gravityForce = CGFloat(-9.8 * self.playerMass)
        let sin = CGFloat(tilt)
        let cos = cos(asin(sin))
        
        let tiltedGravityVector = CGVector(dx: gravityForce*sin, dy: gravityForce*cos)
        
        return tiltedGravityVector
    }
    
    func applyGravity(node: SKNode) {
        let action = SKAction.run {
            let tiltedGravityVector = self.getTiltedGravityVector()
            let fixedGravity = CGVector(dx: tiltedGravityVector.dx, dy: tiltedGravityVector.dy)
            self.physicsWorld.gravity = fixedGravity
        }
        
        node.run(action)
    }
    
    func jump(node: SKNode) {
//        if isOnGround {
            let tiltedGravityVector = getTiltedGravityVector()
            node.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -tiltedGravityVector.dy*jumpIntensity))
            isOnGround = false
//        }
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
    
    func fixCamera(cameraNode: SKCameraNode) {
        cameraNode.position.x = playerNode.position.x
        cameraNode.position.y = playerNode.position.y + cameraFixedY
        cameraNode.setScale(zoomScale)
        
        backgroundNode.position = playerNode.position
    }
    
    func reposition(player: SKSpriteNode, ground: SKSpriteNode) {
        if (player.position.y < -ground.frame.height) {
            playerNode.position = CGPoint(x: frame.midX, y: frame.midY)
        }
    }
    
}
