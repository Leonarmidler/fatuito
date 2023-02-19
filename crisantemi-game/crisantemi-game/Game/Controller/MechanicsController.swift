//
//  Mechanics.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreMotion

struct MechanicsController {
    static func getInclination(motionManager: CMMotionManager) -> Double {
        var inclination: Double = 0
        
        if motionManager.accelerometerData != nil {
            inclination = motionManager.accelerometerData!.acceleration.y
        }
        
        return inclination
    }
    
    static func getTiltedGravityVector(motionManager: CMMotionManager) -> CGVector {
        let tilt = checkTilt(actualTilt: getInclination(motionManager: motionManager))
        let gravityForce = CGFloat(-9.8 * GameParameters.playerMass)
        let sin = CGFloat(tilt)
        let cos = cos(asin(sin))
        
        let tiltedGravityVector = CGVector(dx: gravityForce*sin, dy: gravityForce*cos)
        
        return tiltedGravityVector
    }
    
    static func applyGravity(motionManager: CMMotionManager) -> CGVector{
        let tiltedGravityVector = self.getTiltedGravityVector(motionManager: motionManager)
        let fixedGravity = CGVector(dx: tiltedGravityVector.dx, dy: tiltedGravityVector.dy)
        
        return fixedGravity
    }
    
    static func jump(node: SKNode, motionManager: CMMotionManager) {
            let tiltedGravityVector = getTiltedGravityVector(motionManager: motionManager)
        node.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -tiltedGravityVector.dy*GameParameters.jumpIntensity))
    }
    
    static func checkTilt(actualTilt: Double) -> Double {
        
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
    
    static func fixCamera(cameraNode: SKCameraNode, playerNode: SKSpriteNode) {
        cameraNode.position.x = playerNode.position.x
        cameraNode.position.y = playerNode.position.y + GameParameters.cameraFixedY
        cameraNode.setScale(GameParameters.zoomScale)
    }
    
    static func reposition(player: SKSpriteNode, ground: SKSpriteNode, scene: SKScene) {
        if (player.position.y < -ground.frame.height) {
            player.position = scene.frame.origin
        }
    }
    
}
