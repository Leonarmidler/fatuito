//
//  ContactHandler.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

extension LevelTest: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.playerCategory && contact.bodyB.categoryBitMask == PhysicsCategory.groundCategory || contact.bodyB.categoryBitMask == PhysicsCategory.playerCategory && contact.bodyA.categoryBitMask == PhysicsCategory.groundCategory {
            isOnGround = true
        }
        if contact.bodyA.node == childNode(withName: "player") && contact.bodyB.node == childNode(withName: "token") || contact.bodyB.node === childNode(withName: "player") && contact.bodyB.node == childNode(withName: "token") {
            GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
        }
    }
    
}
