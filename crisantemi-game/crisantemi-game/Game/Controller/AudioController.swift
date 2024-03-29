//
//  AudioController.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 28/02/23.
//

import SwiftUI
import AVFoundation

class AudioController {
    // AUDIOPLAYER
    static let arrowClick = setupAudio(audioPlayerName: "arrowClick")
    static let buttonClick = setupAudio(audioPlayerName: "buttonClick")
    static let jump = [setupAudio(audioPlayerName: "jump1"), setupAudio(audioPlayerName: "jump2")]
    static let fatuumHit = setupAudio(audioPlayerName: "fatuumsPickup")
    static let gulaguForest = setupAudio(audioPlayerName: "gulaguForest")
    
    static private func setupAudio(audioPlayerName: String) -> AVAudioPlayer{
        var audioPlayer = AVAudioPlayer()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: audioPlayerName, withExtension: "wav")!)
            audioPlayer.prepareToPlay()
        } catch {
            print("Error loading sound file: \(error)")
        }
        
        return audioPlayer
    }
    
    static func playSound(audioPlayer: AVAudioPlayer) {
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    static func playSoundForever(audioPlayer: AVAudioPlayer) {
        audioPlayer.currentTime = 0
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    static func stopAudio(audioPlayer: AVAudioPlayer) {
        audioPlayer.stop()
    }
    
}
