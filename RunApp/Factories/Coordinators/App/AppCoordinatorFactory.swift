//
//  BaseViewProtocol.swift
//  RunChecker
//
//  Created by Мария Хатунцева on 22.02.2023.
//

protocol AppCoordinatorFactory {

    func makeLaunching(router: Routable) -> LaunchCoordinatorOutput

    func makeTabBar(router: Routable) -> TabBarCoordinatorOutput
}
