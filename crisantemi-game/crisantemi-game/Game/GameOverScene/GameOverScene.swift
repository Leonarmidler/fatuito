//
//  GameOverScene.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 28/02/23.
//

import Foundation
import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class GameOverScene: SKScene {
    
    var gameOverNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        addGameOverLabel()
    }
    
    func addGameOverLabel() {
        gameOverNode.text = "GAME OVER"
        gameOverNode.fontName = "Fatuito"
        gameOverNode.fontSize = GameParameters.fontSize*5
        gameOverNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        gameOverNode.name = "gameOver"
        addChild(gameOverNode)
    }
    
}
