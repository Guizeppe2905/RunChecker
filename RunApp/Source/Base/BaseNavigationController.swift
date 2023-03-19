//
//  BaseNavigationController.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isTranslucent = false
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = nil
        self.interactivePopGestureRecognizer?.isEnabled = self.responds(
            to: #selector(getter: interactivePopGestureRecognizer)
        ) && self.viewControllers.count > 1
        performAdditionalSetup()
    }
    
    private func performAdditionalSetup() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundColor = Colors.energyGreen
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension BaseNavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        self.interactivePopGestureRecognizer?.isEnabled = self.responds(
            to: #selector(getter: interactivePopGestureRecognizer)
        ) && self.viewControllers.count > 1
    }
    
}

