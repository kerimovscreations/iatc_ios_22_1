//
//  FontProvider.swift
//  Session 1
//
//  Created by Karim Karimov on 18.06.22.
//

import Foundation
import UIKit

class FontProvider {
    
    func getFont(type: FontType) -> UIFont {
        guard let customFont = UIFont(name: type.getName(), size: CGFloat(type.getSize())) else {
            fatalError("""
                Failed to load the "\(type.getName())" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        
        return customFont
    }
    
}

enum FontType {
    case timer_pause, timer_running, heading, label, text_regular, text_small

    func getName() -> String {
        switch self {
        case .timer_running,
                .heading:
            return "RobotoFlexNormalNormalNormalNormalNormalNormalNormalNormalNormalDefault-Bold"
        case .label:
            return "RobotoFlexNormalNormalNormalNormalNormalNormalNormalNormalNormalDefault-Medium"
        case .text_regular,
                .text_small,
                .timer_pause:
            return "RobotoFlex-Regular"
        }
    }
    
    func getSize() -> Int {
        switch self {
        case .timer_pause,
                .timer_running:
            return 256
        case .heading,
                .label:
            return 24
        case .text_regular:
            return 16
        case .text_small:
            return 12
        }
    }
}
