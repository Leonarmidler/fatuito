//
//  LevelContactController.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation
import SwiftUI

extension LevelCreator: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        checkCollision(contact: contact)
    }
    
    func checkCollision(contact: SKPhysicsContact) {
        if contact.bodyA.node == playerNode {
            if contact.bodyB.node?.name == "fatuum" {
                contactPlayerFatuum(fatuumParentNode: contact.bodyB.node!)
            }
            if contact.bodyB.node?.parent == groundParentNode {
                contactPlayerGround()
            }
            if contact.bodyB.node?.parent == tokenNode {
                contactPlayerToken()
            }
        } else if contact.bodyB.node == playerNode {
            if contact.bodyA.node?.name == "fatuum" {
                contactPlayerFatuum(fatuumParentNode: contact.bodyA.node!)
            }
            if contact.bodyA.node?.parent == groundParentNode {
                contactPlayerGround()
            }
            if contact.bodyA.node?.parent == tokenNode {
                contactPlayerToken()
            }
        }
    }
    
    func contactPlayerGround() {
        canJump = true
    }
    
    func contactPlayerToken() {
        if points >= minPoints {
            GameParameters.isWon = true
        } else {
            GameParameters.isWon = false
        }
        GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
    }
    
    func contactPlayerFatuum(fatuumParentNode: SKNode) {
        AudioController.playSound(audioPlayer: AudioController.fatuumHit)
        fatuumParentNode.removeFromParent()
        scoreNode.removeFromParent()
        points = MechanicsController.addPoint(actualPoints: points)
        addScore()
    }
}
