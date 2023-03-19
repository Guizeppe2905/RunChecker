//
//  HomeAssembly.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol HomeAssemblable: HomePresenterOutputToView {
    func setupDependencies(presenter: HomePresenterInputFromView)
}

enum HomeAssembly {
    static func assemblyModule(with view: HomeAssemblable) -> HomeAssemblable {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        interactor.setupDependencies(presenter: presenter)
        presenter.setupDependencies(view: view,
                                    interactor: interactor)
        view.setupDependencies(presenter: presenter)
        return view
    }
}
