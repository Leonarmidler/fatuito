//
//  Pause.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 08/03/23.
//

import SpriteKit

class Pause: SKScene {
    
    // NODES
    var resumeNode = SKLabelNode()
    var quitNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        scene!.backgroundColor = .clear
        
        addResumeNode()
        addQuitNode()
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    func addResumeNode() {
        resumeNode.text = "Resume"
        resumeNode.fontName = "Fatuito"
        resumeNode.fontSize = GameParameters.inGameFontSize
        
        resumeNode.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        resumeNode.zPosition = 5
        
        resumeNode.name = "resume"
        addChild(resumeNode)
    }
    
    func addQuitNode() {
        quitNode.text = "Quit"
        quitNode.fontName = "Fatuito"
        quitNode.fontSize = GameParameters.inGameFontSize
        
        quitNode.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        quitNode.zPosition = 5
        
        quitNode.name = "quit"
        addChild(quitNode)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            switch node.name {
            case "resume":
                self.removeAllChildren()

                break
            case "quit":
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
