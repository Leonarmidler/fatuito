//
//  LevelTouchController.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import UIKit
import SpriteKit
import GameplayKit

extension LevelCreator {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            
            if self.notPaused {
                switch node.name {
                case "menu":
                    AudioController.playSound(audioPlayer: AudioController.buttonClick)
                    scene?.isPaused = true
                    addQuitNode()
                    addResumeNode()
                    shouldUpdate.toggle()
                    notPaused.toggle()
                    break
                default:
                    if canJump {
                        MechanicsController.jump(node: playerNode, motionManager: motionManager)
                        canJump = false
                    }
                    break
                }
            } else {
                switch node.name {
                case "resume":
                    scene?.isPaused = false
                    resumeNode.removeFromParent()
                    quitNode.removeFromParent()
                    notPaused.toggle()
                    shouldUpdate.toggle()
                    break
                case "quit":
                    // SWITCH SCENE
                    shouldUpdate = false
                    AudioController.playSound(audioPlayer: AudioController.buttonClick)
                    let menuScene = Menu(fileNamed: "MenuScene")!
                    menuScene.scaleMode = .aspectFill
                    GameParameters.switchScene(fromScene: self, toScene: menuScene)
                    break
                default:
                    break
                }
            }
        }
    }
    
    
    // ALL TOUCH FUNCTIONS
    func touchDown(atPoint pos : CGPoint) {}
    func touchMoved(toPoint pos : CGPoint) {}
    func touchUp(atPoint pos : CGPoint) {}
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
}
