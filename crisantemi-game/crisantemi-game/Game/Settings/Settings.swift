//
//  Settings.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 08/03/23.
//

import Foundation
import SpriteKit

class Settings: SKScene {
    // NODES
    var backButtonNode = SKLabelNode()
    var languageLabel = SKLabelNode()
    var controlLabel = SKLabelNode()
    var controlGyro = SKLabelNode()
    var controlTouch = SKLabelNode()
    var itaLabel = SKLabelNode()
    var usaLabel = SKLabelNode()

    override func didMove(to view: SKView) {
        // Add credits content here
        addTitleScreen()
        
        addLanguageLabel()
        addItaFlag()
        addUsaFlag()
        
        addControlLabel()
        addControlTouch()
        addControlGyro()
        
        addBackButton()
    }
    
    func addControlGyro() {
        controlGyro.text = "GYRO"
        controlGyro.fontName = "Fatuito"
        
        controlGyro.fontSize = GameParameters.fontSize/3
        controlGyro.position = CGPoint(x: frame.midX + 0.5*frame.width/7, y: frame.midY + frame.height/8)
        
        controlGyro.name = "gyro"
        addChild(controlGyro)
    }
    
    func addControlTouch() {
        controlTouch.text = "TOUCH"
        controlTouch.fontName = "Fatuito"
        
        controlTouch.fontSize = GameParameters.fontSize/3
        controlTouch.position = CGPoint(x: frame.midX + 2*frame.width/7, y: frame.midY + frame.height/8)
        controlTouch.alpha = 0.5
        
        controlTouch.name = "touch"
        addChild(controlTouch)
    }
    
    func addItaFlag() {
        itaLabel.text = "ITA"
        itaLabel.fontName = "Fatuito"
        
        itaLabel.fontSize = GameParameters.fontSize/3
        itaLabel.position = CGPoint(x: frame.midX + 0.5*frame.width/7, y: frame.midY - frame.height/8)
        itaLabel.alpha = 0.5
        
        itaLabel.name = "ita"
        addChild(itaLabel)
    }
    
    func addUsaFlag() {
        usaLabel.text = "ENG"
        usaLabel.fontName = "Fatuito"
        
        usaLabel.fontSize = GameParameters.fontSize/3
        usaLabel.position = CGPoint(x: frame.midX + 2*frame.width/7, y: frame.midY - frame.height/8)
        
        usaLabel.name = "usa"
        addChild(usaLabel)
    }
    
    func addTitleScreen() {
        var title = SKLabelNode()
        title.text = "OPTIONS"
        title.fontName = "Fatuito"
        
        title.fontSize = GameParameters.fontSize/2
        title.position = CGPoint(x: frame.midX, y: frame.midY + frame.height/3)
        addChild(title)
    }
    
    func addControlLabel() {
        controlLabel.text = "Controls:"
        controlLabel.fontName = "Fatuito"
        controlLabel.scene?.anchorPoint = CGPoint(x: 0, y: 0)
        
        controlLabel.fontSize = GameParameters.fontSize/3
        controlLabel.position = CGPoint(x: frame.midX - frame.width/5, y: frame.midY + frame.height/8)

        controlLabel.name = "control"
        addChild(controlLabel)
    }
    
    func addLanguageLabel() {
        languageLabel.text = "Language:"
        languageLabel.fontName = "Fatuito"
        languageLabel.scene?.anchorPoint = CGPoint(x: 0, y: 0)
        
        languageLabel.fontSize = GameParameters.fontSize/3
        languageLabel.position = CGPoint(x: frame.midX - frame.width/5, y: frame.midY - frame.height/8)

        languageLabel.name = "language"
        addChild(languageLabel)
    }
    
    func addBackButton() {
        backButtonNode.text = "<"
        backButtonNode.fontName = "Fatuito"
        
        backButtonNode.fontSize = GameParameters.fontSize/2
        backButtonNode.position = CGPoint(x: frame.midX - GameParameters.frameWidth/7.5, y: frame.midY - GameParameters.frameHeight/7.5)

        backButtonNode.name = "backButton"
        addChild(backButtonNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            switch node.name {
            case "usa":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                usaLabel.alpha = 1
                itaLabel.alpha = 0.5
                break
            case "ita":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                itaLabel.alpha = 1
                usaLabel.alpha = 0.5
                break
            case "gyro":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                controlGyro.alpha = 1
                controlTouch.alpha = 0.5
                break
            case "touch":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                controlTouch.alpha = 1
                controlGyro.alpha = 0.5
                break
                
            case "backButton":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
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
