//
//  TabBarCoordinatorFactory.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol TabBarCoordinatorFactory {

    func makeHome(router: Routable) -> HomeCoordinatorOutput

    func makeHistory(router: Routable) -> HistoryCoordinatorOutput
    
    func makeCurrentRun(router: Routable) -> CurrentRunCoordinatorOutput

}
