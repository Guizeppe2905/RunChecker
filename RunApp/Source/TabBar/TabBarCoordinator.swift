//
//  TabBarCoordinator.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

protocol TabBarCoordinatorOutput: Coordinatable {
    var finishFlow: CompletionBlock? { get set }
}

final class TabBarCoordinator: BaseCoordinator,
                               TabBarCoordinatorOutput {

    var finishFlow: CompletionBlock?
    private let coordinatorsFactory: TabBarCoordinatorFactory
    private var itemRouters = [TabItem: Router]()
    
    private weak var homeCoordinator: HomeCoordinator?
    private weak var historyCoordinator: HistoryCoordinator?
    
    private let tabBarViewController = TabBarViewController()

    init(coordinatorFactory: TabBarCoordinatorFactory,
         router: Routable) {
        self.coordinatorsFactory = coordinatorFactory
        super.init(router: router)
        tabBarViewController.selectedIndex = 0
        TabItem.allCases.forEach { createCoordinator(at: $0) }
    }

    func start() {
        performFlow()
    }
  
    private func createCoordinator(at type: TabItem) {
        let navController = BaseNavigationController()
        let router = Router(rootController: navController)
        
        switch type {
            
        case .home:
            let homeCoordinator = coordinatorsFactory.makeHome(
                router: router
            )
            homeCoordinator.finishFlow = nil
            homeCoordinator.start()
            addDependency(homeCoordinator)
            
        case .history:
            let catalogCoordinator = coordinatorsFactory.makeHistory(
                router: router
            )
            catalogCoordinator.finishFlow = nil
            catalogCoordinator.start()
            addDependency(catalogCoordinator)

        }
        
        itemRouters[type] = router
    }
    
    private func performFlow() {
        var controllers = [UIViewController]()
        TabItem.allCases.forEach { item in
            if let vc = itemRouters[item]?.toPresent {
                controllers.append(vc)
            }
        }
        tabBarViewController.setViewControllers(controllers,
                                                animated: false)
        router.setRootModule(tabBarViewController,
                             hideNavigationBar: true,
                             rootAnimated: false)
    }
    
}

extension TabBarCoordinator {
    
    enum TabItem: String, CaseIterable {
        case home
        case history
    }
}

