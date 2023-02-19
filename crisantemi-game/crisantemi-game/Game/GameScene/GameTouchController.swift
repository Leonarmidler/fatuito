//
//  TouchController.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import UIKit
import SpriteKit
import GameplayKit

extension GameScene {
    
    func touchDown(atPoint pos : CGPoint) {
//        print("touchDown")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        print("touchMoved")
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        print("touchUp")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesBegan")
        mechanicsController.jump(node: playerNode, motionManager: motionManager)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesMoved")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesEnded")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesCancelled")
    }
    
}
