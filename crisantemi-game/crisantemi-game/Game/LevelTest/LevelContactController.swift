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
import SwiftUI

extension LevelTest: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        //        if contact.bodyA.node == childNode(withName: "player") && contact.bodyA.node == childNode(withName: "ground") || contact.bodyB.node == childNode(withName: "player") && contact.bodyA.node == childNode(withName: "ground") {
        //            isOnGround = true
        //        }
        //        if contact.bodyA.node == childNode(withName: "player") && contact.bodyB.node == childNode(withName: "token") || contact.bodyB.node == childNode(withName: "player") && contact.bodyB.node == childNode(withName: "token") {
        //            GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
        //        }
        
        checkCollision(contact: contact)
    }
    
    func checkCollision(contact: SKPhysicsContact) {
        if contact.bodyA.node == childNode(withName: "circle") {
            if contact.bodyB.node?.parent == childNode(withName: "ground") {
                print("GROUND A")
                isOnGround = true
            }
            if contact.bodyB.node?.parent == childNode(withName: "token") {
                GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
            }
        } else if contact.bodyB.node == childNode(withName: "circle") {
            if contact.bodyA.node?.parent == childNode(withName: "ground") {
                print("GROUND B")
                isOnGround = true
            }
            if contact.bodyA.node?.parent == childNode(withName: "token") {
                GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
            }
        }
        
//        if contact.bodyA.contactTestBitMask == PhysicsCategory.player {
//            if contact.bodyB.contactTestBitMask == PhysicsCategory.ground {
//                print("GROUND A - PC")
//                isOnGround = true
//            }
//            if contact.bodyB.contactTestBitMask == PhysicsCategory.token {
//                GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
//            }
//        } else if contact.bodyB.contactTestBitMask == PhysicsCategory.player {
//            if contact.bodyA.contactTestBitMask == PhysicsCategory.ground {
//                print("GROUND B - PC")
//                isOnGround = true
//            }
//            if contact.bodyA.contactTestBitMask == PhysicsCategory.token {
//                GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
//            }
//        }

        
    }
    
}
