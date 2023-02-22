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
    var buttonNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        // Add menu content here
        addStartButton()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func addStartButton() {
        let buttonTexture = SKTexture(imageNamed: "startButton")
        
        buttonNode = SKSpriteNode(texture: buttonTexture)
        buttonNode.size = buttonTexture.size()
        buttonNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(buttonNode)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        GameParameters.switchScene(fromScene: self, toScene: LevelTest(size: self.size))
    }
}
