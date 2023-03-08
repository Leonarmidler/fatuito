//
//  TextController.swift
//  Fatuito
//
//  Created by Leonardo Daniele on 09/03/23.
//

import Foundation

class TextController {
    
    static var isEnglish = true
    
    static func controlGyro() -> String {
        if isEnglish {
            return "GYRO"
        } else {
            return "GIRO"
        }
    }
    
    static func controlTouch() -> String {
        if isEnglish {
            return "TOUCH"
        } else {
            return "TOCCO"
        }
    }
    
    static func optionTitle() -> String {
        if isEnglish {
            return "OPTIONS"
        } else {
            return "OPZIONI"
        }
    }
    
    static func controlLabel() -> String {
        if isEnglish {
            return "Controls:"
        } else {
            return "Controlli:"
        }
    }
    
    static func languageLabel() -> String {
        if isEnglish {
            return "Language:"
        } else {
            return "Lingua:"
        }
    }
    
    static func playNode() -> String {
        if isEnglish {
            return "PLAY"
        } else {
            return "GIOCA"
        }
    }
    
    static func creditsLabel() -> String {
        if isEnglish {
            return "CREDITS"
        } else {
            return "CREDITI"
        }
    }
    
    static func settingsLabel() -> String {
        if isEnglish {
            return "SETTINGS"
        } else {
            return "IMPOSTAZIONI"
        }
    }
    
    static func selectStageNode() -> String {
        if isEnglish {
            return "SELECT STAGE"
        } else {
            return "SELEZIONA STAGE"
        }
    }
    
    static func resumeNode() -> String {
        if isEnglish {
            return "Resume"
        } else {
            return "Riprendi"
        }
    }
    
    static func quitNode() -> String {
        if isEnglish {
            return "Quit"
        } else {
            return "Esci"
        }
    }
    
    static func lostText() -> String {
        if isEnglish {
            return "YOU LOST"
        } else {
            return "HAI PERSO"
        }
    }
    
    static func winText() -> String {
        if isEnglish {
            return "YOU WIN"
        } else {
            return "HAI VINTO"
        }
    }
    
    static func restartNode() -> String {
        if isEnglish {
            return "Home"
        } else {
            return "Menu"
        }
    }
    
}
