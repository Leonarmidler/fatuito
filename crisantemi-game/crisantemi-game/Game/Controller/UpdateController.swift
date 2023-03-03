//
//  UpdateController.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 02/03/23.
//

import SwiftUI
import SpriteKit

struct UpdateController {
    
    static func fixFramePosition(playerNode: SKNode, menuNode: SKNode, scoreNode: SKNode) {
        let newScale = GameParameters.zoomScale(playerNode: playerNode)
        
        let menuNewPosition = CGPoint(x: playerNode.position.x + GameParameters.menuButtonOffsetX(playerNode: playerNode), y: playerNode.position.y + GameParameters.menuButtonOffsetY(playerNode: playerNode))
        menuNode.position = menuNewPosition
        menuNode.setScale(newScale)
        
        let scoreNewPosition = CGPoint(x: playerNode.position.x + GameParameters.scoreOffsetX(playerNode: playerNode), y: playerNode.position.y + GameParameters.scoreOffsetY(playerNode: playerNode))
        scoreNode.position = scoreNewPosition
        scoreNode.setScale(newScale)
    }
    
    static func fixCamera(cameraNode: SKNode, playerNode: SKNode) {
        cameraNode.position = CGPoint(x: playerNode.position.x + GameParameters.cameraFixedX, y: playerNode.position.y + GameParameters.cameraFixedY)
        cameraNode.setScale(GameParameters.zoomScale(playerNode: playerNode))
    }
}
