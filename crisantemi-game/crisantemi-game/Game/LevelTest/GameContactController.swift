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
    static let circleCategory : UInt32 = 0b0010
    static let groundCategory : UInt32 = 0b0011
}

extension LevelTest: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "circle" {
            isOnGround = true
        }
    }
    
}
