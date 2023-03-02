//
//  PhysicsController.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 28/02/23.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
    static let none   : UInt32 = 0
    static let player : UInt32 = 0b0001
    static let circle : UInt32 = 0b0010
    static let ground : UInt32 = 0b0011
    static let token  : UInt32 = 0b0100
    static let fatuum : UInt32 = 0b0101
}

struct PhysicsController {

    static func setupNode(node: SKNode, nodeSelfCategory: UInt32, nodeCollisionCategory: UInt32) {
        node.physicsBody?.categoryBitMask = nodeSelfCategory
        node.physicsBody?.collisionBitMask = nodeCollisionCategory
        node.physicsBody?.contactTestBitMask = nodeCollisionCategory
        node.physicsBody?.friction = GameParameters.stdFriction
    }
    
}
