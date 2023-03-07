//
//  UpdateController.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 02/03/23.
//

import SwiftUI
import SpriteKit

struct UpdateController {
    
    static func fixFramePosition(playerNode: SKNode, menuNode: SKNode, scoreNode: SKNode, cameraNode: SKNode) {
        // SCALE MENU AND SCORE
        let newScale = GameParameters.zoomScale(playerNode: playerNode)
        let scaleAction = SKAction.scale(to: newScale, duration: 0.1)
        menuNode.run(scaleAction)
        scoreNode.run(scaleAction)
        
        
        // MOVE MENU
        let menuNewPosition = CGPoint(x: playerNode.position.x + GameParameters.menuButtonOffsetX(playerNode: playerNode), y: cameraNode.position.y + GameParameters.menuButtonOffsetY(playerNode: playerNode))
        let menuMoveAction = SKAction.move(to: menuNewPosition, duration: 0.1)
        
        menuNode.run(menuMoveAction)
        
        // MOVE SCORE
        let scoreNewPosition = CGPoint(x: playerNode.position.x + GameParameters.scoreOffsetX(playerNode: playerNode), y: cameraNode.position.y + GameParameters.scoreOffsetY(playerNode: playerNode))
        let scoreMoveAction = SKAction.move(to: scoreNewPosition, duration: 0.1)
    
        scoreNode.run(scoreMoveAction)
    }
    
    static func fixCamera(cameraNode: SKNode, playerNode: SKNode, wallParentNode: SKNode) {
        var newPosition = CGPoint(x: playerNode.position.x + GameParameters.cameraFixedX, y: playerNode.position.y + GameParameters.cameraFixedY)
        let zoomScale = GameParameters.zoomScale(playerNode: playerNode)
        
        for childrenNode in wallParentNode.children {
            let distanceX = abs(childrenNode.position.x - playerNode.position.x)
            if distanceX <= 100/zoomScale {
                newPosition.x = cameraNode.position.x
                break
            } else {
                newPosition = CGPoint(x: playerNode.position.x + GameParameters.cameraFixedX, y: playerNode.position.y + GameParameters.cameraFixedY)
            }
        }
        
        let moveAction = SKAction.move(to: newPosition, duration: GameParameters.cameraMovevementDelay)
        cameraNode.run(moveAction)
        
        let scaleAction = SKAction.scale(to: zoomScale, duration: GameParameters.cameraZoomDelay)
        cameraNode.run(scaleAction)
    }
}
