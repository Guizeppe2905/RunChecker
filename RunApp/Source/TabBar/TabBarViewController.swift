//
//  TabBarViewController.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = Colors.lightSand
        tabBar.backgroundColor = Colors.darkGreen.withAlphaComponent(0.6)
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
        createViewControllers(for: HomeViewController(), title: "Бег", systemImage: "hare"),
        createViewControllers(for: HistoryViewController(), title: "Записи", systemImage: "clock")
        ]
    }

    private func createViewControllers(for viewController: UIViewController,
                                       title: String,
                                       systemImage: String) -> UIViewController {
        let iconSymbol = UIImage(systemName: systemImage)
        let selectedSymbol = UIImage(systemName: systemImage,
                                     withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        let tabBarItem = UITabBarItem(title: title, image: iconSymbol, selectedImage: selectedSymbol)
        viewController.tabBarItem = tabBarItem
        return viewController
    }
}
