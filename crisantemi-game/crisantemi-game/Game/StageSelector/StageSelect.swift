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
    var leonardoNode = SKLabelNode()
    var giovanniNode = SKLabelNode()
    var nikoNode = SKLabelNode()
    var soniaNode = SKLabelNode()
    var alinaNode = SKLabelNode()
    var anitaNode = SKLabelNode()
    var backButtonNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        addLeonardo()
        addGiovanni()
        addNiko()
        addSonia()
        addAlina()
        addAnita()
        addBackButton()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func addLeonardo() {
        leonardoNode.text = "Gulagu Forest"
        leonardoNode.fontName = "Fatuito"
        
        leonardoNode.fontSize = GameParameters.fontSize/2
        leonardoNode.position = CGPoint(x: frame.midX - frame.width/5, y: frame.midY + frame.height/4)
        
//        leonardoNode.alpha = GameParameters.nonClickableLabelOpacity
        
        leonardoNode.name = "gulaguForest"
        addChild(leonardoNode)
    }
    
    func addGiovanni() {
        giovanniNode.text = "???"
        giovanniNode.fontName = "Fatuito"
        
        giovanniNode.fontSize = GameParameters.fontSize/2
        giovanniNode.position = CGPoint(x: frame.midX - frame.width/5, y: frame.midY)
        
        giovanniNode.alpha = GameParameters.nonClickableLabelOpacity
        
        giovanniNode.name = "giovanni"
        addChild(giovanniNode)
    }
    
    func addNiko() {
        nikoNode.text = "???"
        nikoNode.fontName = "Fatuito"
        
        nikoNode.fontSize = GameParameters.fontSize/2
        nikoNode.position = CGPoint(x: frame.midX - frame.width/5, y: frame.midY - frame.height/4)
        
        nikoNode.alpha = GameParameters.nonClickableLabelOpacity
        
        nikoNode.name = "niko"
        addChild(nikoNode)
    }
    
    func addSonia() {
        soniaNode.text = "???"
        soniaNode.fontName = "Fatuito"
        
        soniaNode.fontSize = GameParameters.fontSize/2
        soniaNode.position = CGPoint(x: frame.midX + frame.width/5, y: frame.midY + frame.height/4)
        
        soniaNode.alpha = GameParameters.nonClickableLabelOpacity
        
        soniaNode.name = "sonia"
        addChild(soniaNode)
    }
    
    func addAlina() {
        alinaNode.text = "???"
        alinaNode.fontName = "Fatuito"
        
        alinaNode.fontSize = GameParameters.fontSize/2
        alinaNode.position = CGPoint(x: frame.midX + frame.width/5, y: frame.midY)
        
        alinaNode.alpha = GameParameters.nonClickableLabelOpacity
        
        alinaNode.name = "alina"
        addChild(alinaNode)
    }
    
    func addAnita() {
        anitaNode.text = "???"
        anitaNode.fontName = "Fatuito"
        
        anitaNode.fontSize = GameParameters.fontSize/2
        anitaNode.position = CGPoint(x: frame.midX + frame.width/5, y: frame.midY - frame.height/4)
        
        anitaNode.alpha = GameParameters.nonClickableLabelOpacity
        
        anitaNode.name = "anita"
        addChild(anitaNode)
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
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                GameParameters.switchScene(fromScene: self, toScene: LevelCreator(fileNamed: "GulaguForest")!)
                break
            case "giovanni":
//                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "niko":
//                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "sonia":
//                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "alina":
//                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "anita":
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

