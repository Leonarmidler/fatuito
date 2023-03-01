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
    var arrowClick = AudioController.setupAudio(audioPlayerName: "arrowClick")
    var buttonClick = AudioController.setupAudio(audioPlayerName: "buttonClick")
    var jump = AudioController.setupAudio(audioPlayerName: "jump1")
    
    static func setupAudio(audioPlayerName: String) -> AVAudioPlayer{
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
    
}
