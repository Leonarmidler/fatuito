//
//  GameParameters.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 19/02/23.
//

import Foundation
import SpriteKit

struct GameParameters {
    
    // DIMENSION
    static let fontSize: CGFloat = 150
    
    // TRANSITION
    static let transitionTime: CGFloat = 3
    
    // VIEW SIZE
    static let circleSize = CGSize(width: 25, height: 25)
    static let playerSize = CGSize(width: 12.5, height: 12.5)
    
    static let frameWidth: CGFloat = 2532
    static let frameHeight: CGFloat = 1170
    
    // CAMERA
    static let cameraFixedX: CGFloat = 150
    static let cameraFixedY: CGFloat = 10
    static let zoomScale: CGFloat = 0.5
    // PHYSICS
    static let gravityScaleFactor: CGFloat = 0.10
    static let playerMass: CGFloat = 0.050
    static let staticObjMass: CGFloat = 10
    static let stdFriction: CGFloat = 0.5
    static let jumpIntensity: CGFloat = 75
    
//    static let jointDamping: CGFloat = 0.7 // Ractive force of joint (STD = 10)
    
    // CHECKS
    var isStarted = false
    var isOnGround = false
    
    static func switchScene(fromScene: SKScene, toScene: SKScene) {
        fromScene.removeAllChildren()
        fromScene.removeFromParent()
        fromScene.view?.presentScene(toScene, transition: .fade(withDuration: transitionTime))
    }
    
}
