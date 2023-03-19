//
//  BaseCoordinator.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import Foundation

class BaseCoordinator: NSObject {
    
    private (set) var router: Routable
    private var childCoordinators: [Coordinatable] = []
    
    init(router: Routable
    ) {
        self.router = router
    }

    func addDependency(_ coordinator: Coordinatable) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinatable?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else {
            return
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func removeAllDependencies() {
        childCoordinators.forEach {
            ($0 as? BaseCoordinator)?.removeAllDependencies()
        }
        childCoordinators.removeAll()
    }
}
