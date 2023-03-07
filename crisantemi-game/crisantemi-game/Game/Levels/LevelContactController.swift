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
            if contact.bodyB.node?.parent == groundParentNode {
                contactPlayerGround()
            }
            if contact.bodyB.node?.parent == tokenNode {
                contactPlayerToken()
            }
        } else if contact.bodyB.node == playerNode {
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
        if score >= LevelCreator.minScore {
            GameParameters.isWon = true
        } else {
            GameParameters.isWon = false
        }
        GameParameters.switchScene(fromScene: self, toScene: GameOver(fileNamed: "GameOverScene")!)
    }
    
    func checkCollision() {
        for childrenNode in fatuumParentNode.children {
            let distanceX = abs(childrenNode.position.x - playerNode.position.x)
            let distanceY = abs(childrenNode.position.y - playerNode.position.y)
            
            if distanceX <= 15 && distanceY <= 15 {
                contactPlayerFatuum(fatumNode: childrenNode)
            }
        }
    }
    
    func contactPlayerFatuum(fatumNode: SKNode){
        AudioController.playSound(audioPlayer: AudioController.fatuumHit)
        let particleEffect = SKEmitterNode(fileNamed: "fatumPickup.sks")!
        particleEffect.position = fatumNode.position
        let actionWait = SKAction.wait(forDuration: 0.3)
        let actionRemove = SKAction.removeFromParent()
        
        addChild(particleEffect)
        fatumNode.removeFromParent()
        score += 1
        scoreNode.text = "\(score)"
        
        particleEffect.run(SKAction.sequence([actionWait, actionRemove]))
    }

}
