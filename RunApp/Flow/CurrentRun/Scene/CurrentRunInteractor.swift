//
//  CurrentRunInteractor.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

final class CurrentRunInteractor: CurrentRunPresenterOutputToInteractor {

    private weak var presenter: CurrentRunPresenterInputFromInteractor?

    func setupDependencies(presenter: CurrentRunPresenterInputFromInteractor) {
        self.presenter = presenter
    }

}
