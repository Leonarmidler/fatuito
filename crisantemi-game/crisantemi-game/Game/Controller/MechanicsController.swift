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
import AVFoundation

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
        let gravityForce = CGFloat(-9.8)*GameParameters.gravityScaleFactor
        let sin = CGFloat(tilt)
        let cos = cos(asin(sin))
        
        let tiltedGravityVector = CGVector(dx: gravityForce*sin, dy: gravityForce*cos)
        
        return tiltedGravityVector
    }
    
    static func jump(node: SKNode, motionManager: CMMotionManager) {
        let tiltedGravityVector = getTiltedGravityVector(motionManager: motionManager)
        node.physicsBody?.velocity.dy = 0
        node.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -tiltedGravityVector.dy+GameParameters.jumpIntensity*GameParameters.playerMass))
    }
    
    static func checkTilt(actualTilt: Double) -> Double {
        let maxTilt = 0.9
        let minTilt = -maxTilt
        var tilt = actualTilt
        
        if actualTilt >= maxTilt {
            tilt = maxTilt
        } else if actualTilt <= minTilt {
            tilt = minTilt
        }
        
        return tilt
    }
    
    static func fixCamera(cameraNode: SKNode, playerNode: SKNode) {
        cameraNode.position.x = playerNode.position.x
        cameraNode.position.y = playerNode.position.y + GameParameters.cameraFixedY
        cameraNode.setScale(GameParameters.zoomScale)
    }
    
    static func reposition(nodeToReposition: SKNode, playerNode: SKNode, refNode: SKNode, spawnPoint: CGPoint) {
        if (nodeToReposition.position.y < -refNode.frame.height) {
            nodeToReposition.position = spawnPoint
            playerNode.position = spawnPoint
            nodeToReposition.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
    }
    
    static func setDynamicAnchorPoint(firstNode: SKNode, secondNode: SKNode, anchorPoint: CGPoint, damping: CGFloat, frequency: CGFloat) -> SKPhysicsJointSpring {
        let joint = SKPhysicsJointSpring.joint(withBodyA: firstNode.physicsBody!, bodyB: secondNode.physicsBody!, anchorA: CGPoint(x: secondNode.frame.midX, y: secondNode.frame.midY), anchorB: anchorPoint)
        
        joint.damping = damping
        joint.frequency = frequency
        
        return joint
    }
    
    static func addPoint() {
        
    }

}
