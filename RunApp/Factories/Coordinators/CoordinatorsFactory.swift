//
//  CoordinatorsFactory.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

final class CoordinatorsFactory: AppCoordinatorFactory,
                                 LaunchCoordinatorFactory,
                                 TabBarCoordinatorFactory,
                                 HomeCoordinatorFactory,
                                 HistoryCoordinatorFactory,
                                 CurrentRunCoordinatorFactory {
    
    private let modulesFactory = ModulesFactory()
    
    func makeLaunching(router: Routable) -> LaunchCoordinatorOutput {
        LaunchCoordinator(coordinatorsFactory: self,
                          modulesFactory: modulesFactory,
                          router: router)
    }
    
    func makeTabBar(router: Routable) -> TabBarCoordinatorOutput {
        TabBarCoordinator(coordinatorFactory: self,
                          router: router)
    }
    
    func makeHome(router: Routable) -> HomeCoordinatorOutput {
        HomeCoordinator(coordinatorsFactory: self,
                          modulesFactory: modulesFactory,
                          router: router)
    }
    
    func makeHistory(router: Routable) -> HistoryCoordinatorOutput {
        HistoryCoordinator(coordinatorsFactory: self,
                          modulesFactory: modulesFactory,
                          router: router)
    }
    
    func makeCurrentRun(router: Routable) -> CurrentRunCoordinatorOutput {
        CurrentRunCoordinator(coordinatorsFactory: self,
                           modulesFactory: modulesFactory,
                           router: router)
    }
}
