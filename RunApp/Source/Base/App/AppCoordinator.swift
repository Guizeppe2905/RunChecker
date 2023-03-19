//
//  ModulesFactory.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import Foundation

final class AppCoordinator: BaseCoordinator,
                            AppCoordinatorCoordinatable {

    private let coordinatorsFactory: AppCoordinatorFactory

    private var instructor: LaunchInstructor {
        LaunchInstructor.setup()
    }
    private static var didShowSplash = false

    init(coordinatorsFactory: AppCoordinatorFactory,
         router: Routable) {
        self.coordinatorsFactory = coordinatorsFactory
        super.init(router: router)
    }

    func start() {
        switch instructor {
        case .splash: performSplash()
        case .main: performTabBar()
        }
    }
    
    private func performSplash() {
        let splashCoordinator = coordinatorsFactory.makeLaunching(
            router: router
        )
        splashCoordinator.finishFlow = { [weak self,
                                          weak splashCoordinator] in
            Self.didShowSplash = true
            self?.removeDependency(splashCoordinator)
            self?.start()
        }
        addDependency(splashCoordinator)
        splashCoordinator.start()
    }

    private func performTabBar() {
        let tabBarCoordinator = coordinatorsFactory.makeTabBar(
            router: router
        )
        tabBarCoordinator.finishFlow = nil
        addDependency(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}

extension AppCoordinator {
    
    private enum LaunchInstructor {
        case main
        case splash
        
        static func setup() -> LaunchInstructor {
            AppCoordinator.didShowSplash ? .main : .splash
        }
        
    }
    
}
