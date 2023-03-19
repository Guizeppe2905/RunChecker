//
//  HistoryAssembly.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol HistoryAssemblable: HistoryPresenterOutputToView {
    func setupDependencies(presenter: HistoryPresenterInputFromView)
}

enum HistoryAssembly {
    static func assemblyModule(with view: HistoryAssemblable) -> HistoryAssemblable {
        let interactor = HistoryInteractor()
        let presenter = HistoryPresenter()
        interactor.setupDependencies(presenter: presenter)
        presenter.setupDependencies(view: view,
                                    interactor: interactor)
        view.setupDependencies(presenter: presenter)
        return view
    }
}
