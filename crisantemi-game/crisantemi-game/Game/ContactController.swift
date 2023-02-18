//
//  ContactHandler.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let none   : UInt32 = 0
    static let playerCategory : UInt32 = 0b1
    static let groundCategory : UInt32 = 0b10
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "ground" || contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "ground"{
            isOnGround = true
        } else {
            isOnGround = false
        }
    }
    
}
