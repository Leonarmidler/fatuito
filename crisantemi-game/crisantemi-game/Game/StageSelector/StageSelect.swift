//
//  StageSelect.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 02/03/23.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class StageSelect: SKScene {
    var levelNode1 = SKLabelNode()
    var levelNode2 = SKLabelNode()
    var levelNode3 = SKLabelNode()
    var backButtonNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        level1()
        level2()
        level3()
        addBackButton()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func level1() {
        levelNode1.text = "Gulagu Forest"
        levelNode1.fontName = "Fatuito"
        
        levelNode1.fontSize = GameParameters.fontSize/2
        levelNode1.position = CGPoint(x: frame.midX, y: frame.midY + frame.height/4)
        
//        levelNode1.alpha = GameParameters.nonClickableLabelOpacity
        
        levelNode1.name = "gulaguForest"
        addChild(levelNode1)
    }
    
    
    func level2() {
        levelNode2.text = "???"
        levelNode2.fontName = "Fatuito"
        
        levelNode2.fontSize = GameParameters.fontSize/2
        levelNode2.position = CGPoint(x: frame.midX, y: frame.midY)
        
        levelNode2.alpha = GameParameters.nonClickableLabelOpacity
        
        levelNode2.name = "level2"
        addChild(levelNode2)
    }
    
    func level3() {
        levelNode3.text = "???"
        levelNode3.fontName = "Fatuito"
        
        levelNode3.fontSize = GameParameters.fontSize/2
        levelNode3.position = CGPoint(x: frame.midX, y: frame.midY - frame.height/4)
        
        levelNode3.alpha = GameParameters.nonClickableLabelOpacity
        
        levelNode3.name = "level3"
        addChild(levelNode3)
    }
    
    func addBackButton() {
        backButtonNode.text = "<"
        backButtonNode.fontName = "Fatuito"
        
        backButtonNode.fontSize = GameParameters.fontSize/2
        backButtonNode.position = CGPoint(x: -frame.width/2.3, y: -frame.height/2.3)

        backButtonNode.name = "backButton"
        addChild(backButtonNode)
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            switch node.name {
            case "gulaguForest":
                // SOUND PLAYED
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                
                // GAME PARAM SET
                LevelCreator.bgSound = AudioController.gulaguForest
                LevelCreator.minScore = 14
                
                // SWITCH
                GameParameters.switchScene(fromScene: self, toScene: LevelCreator(fileNamed: "GulaguForest")!)
                break
            case "level2":
//                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "backButton":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                let menuScene = Menu(fileNamed: "MenuScene")!
                menuScene.scaleMode = .aspectFill
                GameParameters.switchScene(fromScene: self, toScene: menuScene)
                break
            default: break
            }
        }
    }
    
}

