//
//  CurrentRunAssembly.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol CurrentRunAssemblable: CurrentRunPresenterOutputToView {
    func setupDependencies(presenter: CurrentRunPresenterInputFromView)
}

enum CurrentRunAssembly {
    static func assemblyModule(with view: CurrentRunAssemblable) -> CurrentRunAssemblable {
        let interactor = CurrentRunInteractor()
        let presenter = CurrentRunPresenter()
        interactor.setupDependencies(presenter: presenter)
        presenter.setupDependencies(view: view,
                                    interactor: interactor)
        view.setupDependencies(presenter: presenter)
        return view
    }
}
