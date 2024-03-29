//
//  GameOverScene.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 28/02/23.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class GameOver: SKScene {
    
    var gameOverNode = SKLabelNode()
    var restartNode = SKLabelNode()
    var lostText = TextController.lostText()
    var winText = TextController.winText()
    
    override func didMove(to view: SKView) {
        addGameOverLabel()
        addRestartLabel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func addGameOverLabel() {
        gameOverNode.text = (GameParameters.isWon ? "\(winText)" : "\(lostText)")
        gameOverNode.fontName = "Fatuito"
        
        gameOverNode.fontSize = GameParameters.fontSize/2
        gameOverNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        gameOverNode.name = "gameOver"
        addChild(gameOverNode)
    }
    
    func addRestartLabel() {
        restartNode.text = TextController.restartNode()
        restartNode.fontName = "Fatuito"
        
        restartNode.fontSize = GameParameters.fontSize/4
        restartNode.position = CGPoint(x: frame.midX, y: frame.midY - GameParameters.fontSize)
        
        restartNode.name = "home"
        addChild(restartNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            switch node.name {
            case "home":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                
                // SWITCH SCENE
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
