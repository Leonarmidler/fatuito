//
//  GameParameters.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 19/02/23.
//

import Foundation
import SpriteKit

struct GameParameters {
    
    // TRANSITION
    static let transitionTime: CGFloat = 2
    
    // VIEW SIZE
    static let frameWidth: CGFloat = 2532
    static let frameHeight: CGFloat = 1170
    
    // CAMERA
    static let cameraFixedX: CGFloat = 150
    static let cameraFixedY: CGFloat = 30
    static let zoomScale: CGFloat = 1
    
    // PHYSICS
    static let playerMass: CGFloat = 0.5
    static let staticObjMass: CGFloat = 1000
    static let stdFriction: CGFloat = 0.5
    static let jumpIntensity: CGFloat = 60
    
    // CHECKS
    var isOnGround = false
    
    static func switchScene(fromScene: SKScene, toScene: SKScene) {
        fromScene.view?.presentScene(toScene, transition: .reveal(with: SKTransitionDirection.up, duration: transitionTime))
        
        fromScene.removeFromParent()
    }
    
}
