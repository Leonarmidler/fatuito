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
    
    func applyGravity(node: SKNode) {
        self.motionManager.startAccelerometerUpdates()
        let action = SKAction.run {
            if self.motionManager.accelerometerData != nil {
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
        cameraNode.position.y = playerNode.position.y + cameraFixedY
        cameraNode.setScale(zoomScale)
    }
    
}
