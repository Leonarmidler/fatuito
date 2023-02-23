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
    static let circleSize = CGSize(width: 25, height: 25)
    static let playerSize = CGSize(width: 12.5, height: 12.5)
    
    static let frameWidth: CGFloat = 2532
    static let frameHeight: CGFloat = 1170
    
    // CAMERA
    static let cameraFixedX: CGFloat = 150
    static let cameraFixedY: CGFloat = 10
    static let zoomScale: CGFloat = 0.075
    
    // PHYSICS
    static let playerMass: CGFloat = 0.075
    static let staticObjMass: CGFloat = 10
    static let stdFriction: CGFloat = 0.5
    static let jumpIntensity: CGFloat = 75
    
//    static let jointDamping: CGFloat = 0.7 // Ractive force of joint (STD = 10)
    
    // CHECKS
    var isOnGround = false
    
    static func switchScene(fromScene: SKScene, toScene: SKScene) {
        fromScene.view?.presentScene(toScene, transition: .reveal(with: SKTransitionDirection.up, duration: transitionTime))
        
        fromScene.removeFromParent()
    }
    
}
