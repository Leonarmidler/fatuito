//
//  AudioController.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 28/02/23.
//

import Foundation
import AVFoundation

struct AudioController {
    
    static func setupAudio(fileName: String) -> AVAudioPlayer {
        let soundFile = Bundle.main.url(forResource: fileName, withExtension: "wav")
        var audioNode = AVAudioPlayer()
        do {
            audioNode = try AVAudioPlayer(contentsOf: soundFile!)
            audioNode.prepareToPlay()
        } catch {
            print("Error loading sound file: \(error)")
        }
        return audioNode
    }
    
    static func playSound(audioNode: AVAudioPlayer){
        audioNode.currentTime = 0
        audioNode.play()
    }
    
}
