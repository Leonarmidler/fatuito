//
//  AnimationController.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import UIKit
import SpriteKit
import GameplayKit

struct AnimationController {
    
    static func animateFatuum(fatuum: SKNode) {
        let animationTextures = [
            SKTexture(imageNamed: "minifatuum1"),
            SKTexture(imageNamed: "minifatuum2"),
            SKTexture(imageNamed: "minifatuum3"),
            SKTexture(imageNamed: "minifatuum4"),
            SKTexture(imageNamed: "minifatuum5"),
            SKTexture(imageNamed: "minifatuum6"),
            SKTexture(imageNamed: "minifatuum7"),
            SKTexture(imageNamed: "minifatuum8"),
            SKTexture(imageNamed: "minifatuum9")
        ]
        
        let animation = SKAction.animate(with: animationTextures, timePerFrame: 0.4)
        let loopAnimation = SKAction.repeatForever(animation)
        
        fatuum.run(loopAnimation)
    }
    
}
