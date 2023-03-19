//
//  UITableViewCell + extension.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import Foundation
import UIKit

public extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    func setSeparatorHidden(_ isHidden: Bool) {
        if isHidden {
            separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
        } else {
            separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
