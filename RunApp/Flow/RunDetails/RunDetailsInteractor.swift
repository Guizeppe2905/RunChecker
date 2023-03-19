//
//  RunDetailsInteractor.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

final class RunDetailsInteractor: RunDetailsPresenterOutputToInteractor {

    private weak var presenter: RunDetailsPresenterInputFromInteractor?

    func setupDependencies(presenter: RunDetailsPresenterInputFromInteractor) {
        self.presenter = presenter
    }

}
