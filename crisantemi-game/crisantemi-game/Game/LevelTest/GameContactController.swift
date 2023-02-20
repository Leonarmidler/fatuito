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
    static let playerCategory : UInt32 = 0b0001
    static let groundCategory : UInt32 = 0b0010
}

extension LevelTest: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "platform") || (contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "platform") {
            isOnGround = true
        }
        
        if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "ground") || (contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "ground") {
            isOnGround = true
        }

    }
 
}
