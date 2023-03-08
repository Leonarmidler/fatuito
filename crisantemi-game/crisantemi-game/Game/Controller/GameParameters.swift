//
//  GameParameters.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 19/02/23.
//

import Foundation
import SpriteKit

class GameParameters {
    // LEVEL BOOL
    static var isWon: Bool = false
    
    // DIMENSION
    static let fontSize: CGFloat = 150
    static let inGameFontSize: CGFloat = fontSize/2.5
    
    // VIEW SIZE
    static let circleSize = CGSize(width: 25, height: 25)
    static let playerSize = CGSize(width: 12.5, height: 12.5)
    
    static let nonClickableLabelOpacity: CGFloat = 0.3

    // FRAME
    static let startingScoreOffsetX: CGFloat = 750
    static let startingScoreOffsetY: CGFloat = 250
    static let startingMenuButtonOffsetX: CGFloat = -750
    static let startingMenuButtonOffsetY: CGFloat = 250
    
    static let frameWidth: CGFloat = 2532
    static let frameHeight: CGFloat = 1170
    
    // TRANSITION
    static let switchSceneTransitionTime: CGFloat = 1
    
    // CAMERA
    static let cameraFixedX: CGFloat = 0
    static let cameraFixedY: CGFloat = 15
    static let startingZoomScale: CGFloat = 0.5
    static let zoomScaleFactor: CGFloat = 0.0007
    static let cameraZoomDelay: CGFloat = 0.4
    static let cameraMovevementDelay: CGFloat = 0.05
    
    // PHYSICS
    static let gravityScaleFactor: CGFloat = 0.2
    static let playerMass: CGFloat = 0.05
    static let staticObjMass: CGFloat = 10
    static let stdFriction: CGFloat = 1
    static let jumpIntensity: CGFloat = 75
    static let removeDistance: CGFloat = 10
    
    // METHODS PARAMETERS
    static func zoomScale(playerNode: SKNode) -> CGFloat {
        var zoomScale: CGFloat = startingZoomScale
        let velocity = sqrt(pow(playerNode.physicsBody!.velocity.dx, 2) + pow(playerNode.physicsBody!.velocity.dy, 2))
        if zoomScale < 1 {
            zoomScale += velocity*zoomScaleFactor
        }
        return zoomScale
    }
    
    static func scoreOffsetX(playerNode: SKNode) -> CGFloat {
        return startingScoreOffsetX*zoomScale(playerNode: playerNode)
    }
    static func scoreOffsetY(playerNode: SKNode) -> CGFloat {
        return startingScoreOffsetY*zoomScale(playerNode: playerNode)
    }
    static func menuButtonOffsetX(playerNode: SKNode) -> CGFloat {
        return startingMenuButtonOffsetX*zoomScale(playerNode: playerNode)
    }
    static func menuButtonOffsetY(playerNode: SKNode) -> CGFloat {
        return startingMenuButtonOffsetY*zoomScale(playerNode: playerNode)
    }
    
    static func switchScene(fromScene: SKScene, toScene: SKScene) {
        AudioController.stopAudio(audioPlayer: AudioController.gulaguForest)
        fromScene.removeAllChildren()
        fromScene.removeFromParent()

        fromScene.view?.presentScene(toScene, transition: .fade(withDuration: switchSceneTransitionTime))
    }
    
    static func setupPlayer(playerNode: SKNode) {
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: GameParameters.playerSize.width/2)
        
        playerNode.physicsBody?.categoryBitMask = PhysicsCategory.player
        playerNode.physicsBody?.collisionBitMask = PhysicsCategory.ground
        playerNode.physicsBody?.contactTestBitMask = PhysicsCategory.ground
        
        playerNode.physicsBody?.mass = GameParameters.playerMass/10
        playerNode.physicsBody?.friction = GameParameters.stdFriction
        
        playerNode.physicsBody?.affectedByGravity = true
        playerNode.physicsBody?.isDynamic = true
        playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.allowsRotation = true
    }
    
    static func setupGround(groundNode: SKNode) {
        groundNode.physicsBody?.categoryBitMask = PhysicsCategory.ground
        groundNode.physicsBody?.collisionBitMask = PhysicsCategory.player
        groundNode.physicsBody?.contactTestBitMask = PhysicsCategory.player
        
        groundNode.physicsBody?.mass = GameParameters.staticObjMass
        groundNode.physicsBody?.friction = GameParameters.stdFriction
        
        groundNode.physicsBody?.isDynamic = false
        groundNode.physicsBody?.allowsRotation = false
        groundNode.physicsBody?.pinned = true
    }
    
}
