//
//  TestController.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    
    func printAccelerometerData() {
        let tilt = self.checkTilt(actualTilt: self.motionManager.accelerometerData!.acceleration.y)
        let sin = CGFloat(tilt)
        let cos = cos(asin(sin))
        print("SIN: \(sin) COS: \(cos)")
    }
    
    func printPosition(node: SKSpriteNode) {
        print("X:\(node.position.x) Y:\(node.position.y)")
    }
    
}
