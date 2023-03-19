//
//  ModulesFactory.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

final class ModulesFactory: LaunchModuleFactory,
                            HomeModuleFactory,
                            HistoryModuleFactory,
                            CurrentRunModuleFactory {
    
    func makeLaunching() -> LaunchViewProtocol {
        let launchView = LaunchViewController()
        let launchModule = LaunchAssembly.assemblyModule(with: launchView)
        return launchModule
    }

    func makeHome() -> HomeViewProtocol {
        let homeView = HomeViewController()
        let homeModule = HomeAssembly.assemblyModule(with: homeView)
        return homeModule
    }
    
    func makeHistory() -> HistoryViewProtocol {
        let historyView = HistoryViewController()
        let historyModule = HistoryAssembly.assemblyModule(with: historyView)
        return historyModule
    }
    
    func makeCurrentRun() -> CurrentRunViewProtocol {
        let currentRunView = CurrentRunViewController()
        let currentRunModule = CurrentRunAssembly.assemblyModule(with: currentRunView)
        return currentRunModule
    }
}
