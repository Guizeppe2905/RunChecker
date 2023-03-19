//
//  Utils.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

enum Utils {}

extension Utils {
    static var safeAreaInsets: UIEdgeInsets {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero
    }
    
    static func safeAreaInsets(for view: UIView) -> UIEdgeInsets {
        view.safeAreaInsets
    }

    static func safeBottomHeight(for controller: UIViewController) -> CGFloat {
        if
            let tabBarHeight = controller.tabBarController?.tabBar.frame.height,
                tabBarHeight > 0
        {
            return tabBarHeight
        } else {
            return safeAreaInsets.bottom
        }
    }
}
