//
//  MenuScene.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 19/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

class MenuScene: SKScene {

    // NODES
    var logoNode: SKSpriteNode!
    var newGameNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        // Add menu content here
        newGameLabel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func newGameLabel() {
        newGameNode.text = "NEW GAME"
        newGameNode.fontName = "Fatuito.ttf"
        newGameNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        newGameNode.name = "newGame"
        addChild(newGameNode)
    }
    
    func continueLabel() {
        
    }

    func optionLabel() {
        
    }
    
    func languageLabel() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            if (node.name == "newGame") {
                GameParameters.switchScene(fromScene: self, toScene: LevelTest(size: self.size))
            }
        }
    }
}
