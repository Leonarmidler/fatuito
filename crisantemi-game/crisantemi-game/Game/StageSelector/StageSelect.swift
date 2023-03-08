//
//  StageSelect.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 08/03/23.
//

import SpriteKit

class StageSelect: SKScene {
    // NODES
    var exists = false
    var backButtonNode = SKLabelNode()
    var selectStageNode = SKLabelNode()
    var stageNameNode = SKLabelNode()
    var startButtonNode = SKLabelNode()
    var selectedName: String = ""
    
    override func didMove(to view: SKView) {
        scene?.size = CGSize(width: GameParameters.frameWidth, height: GameParameters.frameHeight)
        addSelectStage()
        addStageName()
        addStartButton()
        addBackButton()
    }
    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
    
    func addSelectStage() {
        selectStageNode.text = "SELECT STAGE"
        selectStageNode.fontName = "Fatuito"
        selectStageNode.fontSize = GameParameters.fontSize/1.5
        
        selectStageNode.position = CGPoint(x: frame.midX + frame.width/3, y: frame.midY - GameParameters.fontSize)

        addChild(selectStageNode)
    }
    
    func addStageName() {
        stageNameNode.text = selectedName
        stageNameNode.fontName = "Fatuito"
        stageNameNode.fontSize = GameParameters.fontSize/1.5
        
        stageNameNode.position = CGPoint(x: frame.midX + frame.width/3, y: frame.midY - 2*GameParameters.fontSize)

        addChild(stageNameNode)
    }
    
    func addStartButton() {
        startButtonNode.text = "START"
        startButtonNode.fontName = "Fatuito"
        startButtonNode.fontSize = GameParameters.fontSize/1.5
        
        startButtonNode.position = CGPoint(x: frame.midX + frame.width/3, y: frame.midY - 3*GameParameters.fontSize)
        
        startButtonNode.name = "start"
        addChild(startButtonNode)
    }
    
    func addBackButton() {
        backButtonNode.text = "<"
        backButtonNode.fontName = "Fatuito"
        
        backButtonNode.fontSize = GameParameters.fontSize*1.5
        backButtonNode.position = CGPoint(x: -frame.width/2.3, y: -frame.height/2.3)

        backButtonNode.name = "backButton"
        addChild(backButtonNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            switch node.name {
            case "gulaguForest":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                stageNameNode.text = "Gulagu Forest"
                exists = true
                break
            case "weppingMountain":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                stageNameNode.text = "Wepping Mountain"
                break
            case "underground":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                GameParameters.switchScene(fromScene: self, toScene: UndergroundLevels(fileNamed: "UndergroundLevelsScene")!)
                exists = false
                break
            case "tartaruEden":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                stageNameNode.text = "Tartaru Eden"
                exists = false
                break
            case "backButton":
                AudioController.playSound(audioPlayer: AudioController.arrowClick)
                let menuScene = Menu(fileNamed: "MenuScene")!
                menuScene.scaleMode = .aspectFill
                GameParameters.switchScene(fromScene: self, toScene: menuScene)
                break
            case "start":
                if exists {
                    // SOUND PLAYED
                    AudioController.playSound(audioPlayer: AudioController.buttonClick)
                    
                    // GAME PARAM SET
                    LevelCreator.bgSound = AudioController.gulaguForest
                    LevelCreator.minScore = 14
                    
                    // SWITCH
                    GameParameters.switchScene(fromScene: self, toScene: LevelCreator(fileNamed: stageNameNode.text!)!)
                }
                break
            default: break
            }
        }
    }
    
}
