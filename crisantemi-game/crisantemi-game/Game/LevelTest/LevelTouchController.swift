//
//  TouchController.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import UIKit
import SpriteKit
import GameplayKit

extension LevelTest {
    
    func touchDown(atPoint pos : CGPoint) {
//        print("touchDown")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        print("touchMoved")
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        print("touchUp")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesBegan")
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            switch node.name {
            case "menu":
                shouldUpdate = false
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                
                // SWITCH SCENE
                let menuScene = Menu(fileNamed: "MenuScene")!
                menuScene.scaleMode = .aspectFill
                GameParameters.switchScene(fromScene: self, toScene: menuScene)
                break
            default:
                if canJump {
                    MechanicsController.jump(node: playerNode, motionManager: motionManager)
                    canJump = false
                }
                break
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesMoved")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesEnded")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesCancelled")
    }
    
}
