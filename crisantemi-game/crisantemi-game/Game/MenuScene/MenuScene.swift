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

class MenuScene: SKScene {
    
    // SELECTOR
    var labelSelector: Int = 0
    var selectedLabel = SKLabelNode()

    // NODES
    var pressArrow = AVAudioPlayer()
    var pressButton = AVAudioPlayer()
    
    var logoNode =  SKSpriteNode()
    var leftArrowNode = SKLabelNode()
    var rightArrowNode = SKLabelNode()
    var playNode = SKLabelNode()
    var stageSelectNode = SKLabelNode()
    var galleryNode = SKLabelNode()
    var quitNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        // Add menu content here
        pressArrow = AudioController.setupAudio(fileName: "pressArrow")
        pressButton = AudioController.setupAudio(fileName: "pressButton")
        
        addLogo()
//        AnimationController.gifAnimation(imageName: "animatedLogo", scene: self)
        addRightArrow()
        addLeftArrow()
        
        addPlayLabel()
        addStageSelectLabel()

        addSelectedLabel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func addSelectedLabel() {
        switch labelSelector {
        case 0: selectedLabel = playNode; break
        case 1: selectedLabel = stageSelectNode; break
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
        
        playNode.name = "newGame"
    }
    
    func addStageSelectLabel() {
        stageSelectNode.text = "STAGE SELECT"
        stageSelectNode.fontName = "Fatuito"
        stageSelectNode.fontSize = GameParameters.fontSize
        stageSelectNode.position = CGPoint(x: frame.midX, y: frame.midY - (2*GameParameters.fontSize))
        
        stageSelectNode.name = "stageSelect"
    }

    func addOptionLabel() {
        
    }
    
    func addLanguageLabel() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            switch node.name {
            case "<":
                AudioController.playSound(audioNode: pressArrow)
                if labelSelector == 1 {
                    labelSelector = -1
                }
                labelSelector += 1
                switchLabel()
                break
            case ">":
                AudioController.playSound(audioNode: pressArrow)
                if labelSelector == 0 {
                    labelSelector = 2
                }
                labelSelector -= 1
                switchLabel()
                break
            case "newGame":
                AudioController.playSound(audioNode: pressButton)
                GameParameters.switchScene(fromScene: self, toScene: LevelTest(fileNamed: "LevelTestScene")!)
                break
            default: break
            }
        }
    }
}
