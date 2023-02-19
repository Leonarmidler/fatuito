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

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == PhysicsCategory.playerCategory && bodyB.categoryBitMask == PhysicsCategory.groundCategory {
            print("TOCCO")
        }
    }
    
}
