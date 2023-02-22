//
//  GameViewController.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and configure the menu scene
        let levelTest = LevelTest(size: CGSize(width: GameParameters.frameWidth, height: GameParameters.frameHeight))
        levelTest.scaleMode = .aspectFill
        
        // Present the menu scene
        if let view = self.view as? SKView {
            view.presentScene(levelTest)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
