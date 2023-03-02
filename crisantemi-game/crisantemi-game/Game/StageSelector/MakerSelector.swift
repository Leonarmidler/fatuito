//
//  StageSelector.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 02/03/23.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class MakerSelector: SKScene {
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
        leonardoNode.text = "Leonardo"
        leonardoNode.fontName = "Fatuito"
        
        leonardoNode.fontSize = GameParameters.fontSize/2
        leonardoNode.position = CGPoint(x: frame.midX - frame.width/4, y: frame.midY + frame.height/4)
        
        leonardoNode.name = "leonardo"
        addChild(leonardoNode)
    }
    
    func addGiovanni() {
        giovanniNode.text = "Giovanni"
        giovanniNode.fontName = "Fatuito"
        
        giovanniNode.fontSize = GameParameters.fontSize/2
        giovanniNode.position = CGPoint(x: frame.midX - frame.width/4, y: frame.midY)
        
        giovanniNode.name = "giovanni"
        addChild(giovanniNode)
    }
    
    func addNiko() {
        nikoNode.text = "Niko"
        nikoNode.fontName = "Fatuito"
        
        nikoNode.fontSize = GameParameters.fontSize/2
        nikoNode.position = CGPoint(x: frame.midX - frame.width/4, y: frame.midY - frame.height/4)
        
        nikoNode.name = "niko"
        addChild(nikoNode)
    }
    
    func addSonia() {
        soniaNode.text = "Sonia"
        soniaNode.fontName = "Fatuito"
        
        soniaNode.fontSize = GameParameters.fontSize/2
        soniaNode.position = CGPoint(x: frame.midX + frame.width/4, y: frame.midY + frame.height/4)
        
        soniaNode.name = "sonia"
        addChild(soniaNode)
    }
    
    func addAlina() {
        alinaNode.text = "Alina"
        alinaNode.fontName = "Fatuito"
        
        alinaNode.fontSize = GameParameters.fontSize/2
        alinaNode.position = CGPoint(x: frame.midX + frame.width/4, y: frame.midY)
        
        alinaNode.name = "alina"
        addChild(alinaNode)
    }
    
    func addAnita() {
        anitaNode.text = "Anita"
        anitaNode.fontName = "Fatuito"
        
        anitaNode.fontSize = GameParameters.fontSize/2
        anitaNode.position = CGPoint(x: frame.midX + frame.width/4, y: frame.midY - frame.height/4)
        
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
            case "<":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "leonardo":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "giovanni":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "niko":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                GameParameters.switchScene(fromScene: self, toScene: NikoLevel1(fileNamed: "NikoLevel1Scene")!)
                break
            case "sonia":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "alina":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "anita":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                break
            case "backButton":
                AudioController.playSound(audioPlayer: AudioController.buttonClick)
                let menuScene = Menu(fileNamed: "MenuScene")!
                menuScene.scaleMode = .aspectFill
                GameParameters.switchScene(fromScene: self, toScene: menuScene)
                break
            default: break
            }
        }
    }
    
}

