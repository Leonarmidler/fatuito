//
//  AnimationController.swift
//  crisantemi-game
//
//  Created by Leonardo Daniele on 18/02/23.
//

import UIKit
import SpriteKit
import GameplayKit

struct AnimationController {
    
    static func loadGIFTextures(named imageName: String) -> [SKTexture]? {
        guard let path = Bundle.main.path(forResource: imageName, ofType: "gif") else {
            print("Error: Could not find file '\(imageName).gif'")
            return nil
        }
        
        guard let data = NSData(contentsOfFile: path) else {
            print("Error: Could not load file '\(imageName).gif'")
            return nil
        }
        
        guard let imageSource = CGImageSourceCreateWithData(data, nil) else {
            print("Error: Could not create image source for '\(imageName).gif'")
            return nil
        }
        
        let frameCount = CGImageSourceGetCount(imageSource)
        var textures = [SKTexture]()
        
        for i in 0..<frameCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else {
                print("Error: Could not create CGImage for frame \(i) of '\(imageName).gif'")
                return nil
            }
            textures.append(SKTexture(cgImage: cgImage))
        }
        
        return textures
    }

    static func gifAnimation(imageName: String, scene: SKScene) {
        if let textures = loadGIFTextures(named: imageName) {
            let animateAction = SKAction.animate(with: textures, timePerFrame: 0.1)
            let repeatAction = SKAction.repeatForever(animateAction)
            let sprite = SKSpriteNode(texture: textures[0])
            sprite.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
            scene.addChild(sprite)
            sprite.run(repeatAction)
        }
    }
    
    
}
