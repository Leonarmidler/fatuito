//
//  MenuScene.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 19/02/23.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class Menu: SKScene {
    // SELECTOR
    var labelSelector: Int = 0
    var selectedLabel = SKLabelNode()

    // NODES    
    var logoNode =  SKSpriteNode()
    var leftArrowNode = SKLabelNode()
    var rightArrowNode = SKLabelNode()
    
    var playNode = SKLabelNode()
    var stageSelectNode = SKLabelNode()
    var creditsLabel = SKLabelNode()
    var quitNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        // Add menu content here
        addLogo()
//        AnimationController.gifAnimation(imageName: "animatedLogo", scene: self)
        addRightArrow()
        addLeftArrow()
        
        addPlayLabel()
        addStageSelectLabel()
        addCreditsNode()

        addSelectedLabel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func addSelectedLabel() {
        switch labelSelector {
        case 0: selectedLabel = playNode; break
        case 1: selectedLabel = stageSelectNode; break
        case 2: selectedLabel = creditsLabel; break
        default: break
        }
        
        addChild(selectedLabel)
    }
    
    func switchLabel() {
        selectedLabel.removeFromParent()
        addSelectedLabel()
    }
        
    func addLogo() {
        logoNode = SKSpriteNode(imageNamed: "logo")
        logoNode.setScale(0.5)
        logoNode.position = CGPoint(x: frame.midX, y: frame.midY + 250)
        
        addChild(logoNode)
    }
    
    func addLeftArrow() {
        leftArrowNode.text = "<"
        leftArrowNode.fontName = "Fatuito"
        leftArrowNode.fontSize = GameParameters.fontSize*2
        leftArrowNode.position = CGPoint(x: frame.midX - logoNode.frame.width/2 - leftArrowNode.frame.width, y: frame.midY - (2.35*GameParameters.fontSize))
        
        leftArrowNode.name = "<"
        addChild(leftArrowNode)
    }
    
    func addRightArrow() {
        rightArrowNode.text = ">"
        rightArrowNode.fontName = "Fatuito"
        rightArrowNode.fontSize = GameParameters.fontSize*2
        rightArrowNode.position = CGPoint(x: frame.midX + logoNode.frame.width/2 + rightArrowNode.frame.width, y: frame.midY - (2.35*GameParameters.fontSize))
        
        rightArrowNode.name = ">"
        addChild(rightArrowNode)
    }
    
    func addPlayLabel() {
        playNode.text = "PLAY"
        playNode.fontName = "Fatuito"
        playNode.fontSize = GameParameters.fontSize
        playNode.position = CGPoint(x: frame.midX, y: frame.midY - (2*GameParameters.fontSize))
        
        playNode.alpha = GameParameters.nonClickableLabelOpacity
        
        playNode.name = "play"
    }
    
    func addStageSelectLabel() {
        stageSelectNode.text = "STAGE SELECT"
        stageSelectNode.fontName = "Fatuito"
        stageSelectNode.fontSize = GameParameters.fontSize
        stageSelectNode.position = CGPoint(x: frame.midX, y: frame.midY - (2*GameParameters.fontSize))
        
        stageSelectNode.name = "stageSelect"
    }
    
    func addCreditsNode() {
        creditsLabel.text = "CREDITS"
        creditsLabel.fontName = "Fatuito"
        creditsLabel.fontSize = GameParameters.fontSize
        creditsLabel.position = CGPoint(x: frame.midX, y: frame.midY - (2*GameParameters.fontSize))
        
        creditsLabel.name = "credits"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            switch node.name {
            case ">":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                if labelSelector == 2 {
                    labelSelector = -1
                }
                labelSelector += 1
                switchLabel()
                break
            case "<":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                if labelSelector == 0 {
                    labelSelector = 3
                }
                labelSelector -= 1
                switchLabel()
                break
            case "play":
                // SOUND PLAYED
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                
                // GAME PARAM SET
                LevelCreator.bgSound = AudioController.gulaguForest
                LevelCreator.minScore = 14
                
                // SWITCH
                GameParameters.switchScene(fromScene: self, toScene: LevelCreator(fileNamed: "GulaguForest")!)
                break
            case "stageSelect":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                GameParameters.switchScene(fromScene: self, toScene: StageSelect(fileNamed: "StageSelectScene")!)
            case "credits":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                GameParameters.switchScene(fromScene: self, toScene: Credits(fileNamed: "CreditsScene")!)
            default: break
            }
        }
    }
}
