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
        checkCollision(contact: contact)
    }
    
    func checkCollision(contact: SKPhysicsContact) {
        if contact.bodyA.node == circleNode {
            if contact.bodyB.node?.parent == groundParentNode {
                groundContact()
            }
            if contact.bodyB.node?.parent == tokenNode {
                tokenContact()
            }
            if contact.bodyB.node?.name == "fatuum" {
                fatuumContact(fatuumParentNode: contact.bodyB.node!)
            }
        } else if contact.bodyB.node == circleNode {
            if contact.bodyA.node?.parent == groundParentNode {
                groundContact()
            }
            if contact.bodyA.node?.parent == tokenNode {
                tokenContact()
            }
            if contact.bodyA.node?.name == "fatuum" {
                fatuumContact(fatuumParentNode: contact.bodyA.node!)
            }
        }
    }
    
    func groundContact() {
        isOnGround = true
    }
    
    func tokenContact() {
        if points >= minPoints {
            GameParameters.isWon = true
        } else {
            GameParameters.isWon = false
        }
        GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
    }
    
    func fatuumContact(fatuumParentNode: SKNode) {
        fatuumParentNode.removeFromParent()
        scoreNode.removeFromParent()
        points = MechanicsController.addPoint(actualPoints: points)
        addScore()
    }
    
}
