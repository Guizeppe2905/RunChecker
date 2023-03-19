//
//  Presentable.swift
//  RunChecker
//
//  Created by Мария Хатунцева on 22.02.2023.
//  
//

import UIKit

protocol Presentable {
    
    var toPresent: UIViewController? { get }
    
}

extension UIViewController: Presentable {
    
    var toPresent: UIViewController? {
        self
    }
}
