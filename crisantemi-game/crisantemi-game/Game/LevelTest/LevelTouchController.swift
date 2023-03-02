//
//  TouchController.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import UIKit
import SpriteKit
import GameplayKit

extension LevelTest {
    
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
        if isOnGround {
            MechanicsController.jump(node: childNode(withName: "circle")!, motionManager: motionManager)
            isOnGround = false
        }
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
