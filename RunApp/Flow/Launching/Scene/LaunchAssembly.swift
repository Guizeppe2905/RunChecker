//
//  LaunchAssembly.swift
//  RunChecker
//
//  Created by Мария Хатунцева on 22.02.2023.
//

protocol LaunchAssemblable: LaunchPresenterOutputToView {
    func setupDependencies(presenter: LaunchPresenterInputFromView)
}

enum LaunchAssembly {
    static func assemblyModule(with view: LaunchAssemblable) -> LaunchAssemblable {
        let interactor = LaunchInteractor()
        let presenter = LaunchPresenter()
        presenter.setupDependencies(view: view,
                                    interactor: interactor)
        view.setupDependencies(presenter: presenter)
        return view
    }
}
