//
//  Credits.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 03/03/23.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class Credits: SKScene {
    // PARAM
    let speedIncrement: CGFloat = 20000
    let teamNameScaleFactor: CGFloat = 0.7
    
    // NODES
    var teamNameNode = SKNode()
    var leonardoNode = SKLabelNode()
    var giovanniNode = SKLabelNode()
    var nikoNode = SKLabelNode()
    var soniaNode = SKLabelNode()
    var alinaNode = SKLabelNode()
    var anitaNode = SKLabelNode()
    var backButtonNode = SKLabelNode()
    
    var scrollingSpeed: CGFloat = 100
    var shouldUpdate = true
    
    override func didMove(to view: SKView) {
        // Add credits content here
        addTeamName()
        addLeonardo()
        addGiovanni()
        addNiko()
        addSonia()
        addAlina()
        addAnita()
        
        scrollDown()
        addBackButton()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if shouldUpdate {
            if teamNameNode.position.y > (GameParameters.frameHeight/6 +  3.7*GameParameters.fontSize)*(2*teamNameScaleFactor) {
                let menuScene = Menu(fileNamed: "MenuScene")!
                menuScene.scaleMode = .aspectFill
                GameParameters.switchScene(fromScene: self, toScene: menuScene)
            }
        }
    }
    
    func scrollDown() {
        let scrollAction = SKAction.move(by: CGVector(dx: 0, dy: 1), duration: 1/scrollingSpeed)
        let sequence = SKAction.sequence([scrollAction, SKAction.run{self.scrollDown()}])
        teamNameNode.run(sequence)
    }
    
    func addTeamName() {
        teamNameNode = SKSpriteNode(imageNamed: "teamName")
        teamNameNode.setScale(teamNameScaleFactor)
        teamNameNode.position = CGPoint(x: frame.midX, y: -1.5*teamNameNode.frame.height)
        
        addChild(teamNameNode)
    }
    
    func addLeonardo() {
        leonardoNode.text = "Leonardo Daniele"
        leonardoNode.fontName = "Fatuito"
        
        leonardoNode.fontSize = GameParameters.fontSize/2
        leonardoNode.position = CGPoint(x: frame.midX, y: -teamNameNode.frame.height - 5*GameParameters.fontSize)
        
        leonardoNode.name = "leonardo"
        teamNameNode.addChild(leonardoNode)
    }
    
    func addGiovanni() {
        giovanniNode.text = "Giovanni Capuano"
        giovanniNode.fontName = "Fatuito"
        
        giovanniNode.fontSize = GameParameters.fontSize/2
        giovanniNode.position = CGPoint(x: frame.midX, y: -teamNameNode.frame.height - 4*GameParameters.fontSize)
        
        giovanniNode.name = "giovanni"
        teamNameNode.addChild(giovanniNode)
    }
    
    func addNiko() {
        nikoNode.text = "Domenico Trotta"
        nikoNode.fontName = "Fatuito"
        
        nikoNode.fontSize = GameParameters.fontSize/2
        nikoNode.position = CGPoint(x: frame.midX, y: -teamNameNode.frame.height - 3*GameParameters.fontSize)
        
        nikoNode.name = "niko"
        teamNameNode.addChild(nikoNode)
    }
    
    func addSonia() {
        soniaNode.text = "Sonia Di Micoli"
        soniaNode.fontName = "Fatuito"
        
        soniaNode.fontSize = GameParameters.fontSize/2
        soniaNode.position = CGPoint(x: frame.midX, y: -teamNameNode.frame.height - 6*GameParameters.fontSize)
        
        soniaNode.name = "sonia"
        teamNameNode.addChild(soniaNode)
    }
    
    func addAlina() {
        alinaNode.text = "Alina Brandizzi"
        alinaNode.fontName = "Fatuito"
        
        alinaNode.fontSize = GameParameters.fontSize/2
        alinaNode.position = CGPoint(x: frame.midX, y: -teamNameNode.frame.height - 1*GameParameters.fontSize)
        
        alinaNode.name = "alina"
        teamNameNode.addChild(alinaNode)
    }
    
    func addAnita() {
        anitaNode.text = "Annamaria De Michele"
        anitaNode.fontName = "Fatuito"
        
        anitaNode.fontSize = GameParameters.fontSize/2
        anitaNode.position = CGPoint(x: frame.midX, y: -teamNameNode.frame.height - 2*GameParameters.fontSize)
        
        anitaNode.name = "anita"
        teamNameNode.addChild(anitaNode)
    }
    
    func addBackButton() {
        backButtonNode.text = "<"
        backButtonNode.fontName = "Fatuito"
        
        backButtonNode.fontSize = GameParameters.fontSize/2
        backButtonNode.position = CGPoint(x: frame.midX - GameParameters.frameWidth/7.5, y: frame.midY - GameParameters.frameHeight/7.5)

        backButtonNode.name = "backButton"
        addChild(backButtonNode)
    }
    
    func speedUp() {
        let actionIncreaseSpeed = SKAction.run {
            self.scrollingSpeed *= self.speedIncrement
        }
        teamNameNode.run(actionIncreaseSpeed)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            switch node.name {
            case "backButton":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                let menuScene = Menu(fileNamed: "MenuScene")!
                menuScene.scaleMode = .aspectFill
                GameParameters.switchScene(fromScene: self, toScene: menuScene)
                break
            default:
                speedUp()
                break
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scrollingSpeed = 40
    }
}
