//
//  Fonts.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

enum BosaWeight {
    case regular
    case bold
}

extension UIFont {
    static func bosanova(_ weight: BosaWeight, size: CGFloat) -> UIFont {
        switch weight {
        case .regular:
            return .init(name: "abosanova", size: size)!
        case .bold:
            return .init(name: "abosanovabold", size: size)!
        }
    }
}
