//
//  RunDetailsAssemly.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol RunDetailsAssemblable: RunDetailsPresenterOutputToView {
    func setupDependencies(presenter: RunDetailsPresenterInputFromView)
}

enum RunDetailsAssembly {
    static func assemblyModule(with view: RunDetailsAssemblable) -> RunDetailsAssemblable {
        let interactor = RunDetailsInteractor()
        let presenter = RunDetailsPresenter()
        interactor.setupDependencies(presenter: presenter)
        presenter.setupDependencies(view: view,
                                    interactor: interactor)
        view.setupDependencies(presenter: presenter)
        return view
    }
}
