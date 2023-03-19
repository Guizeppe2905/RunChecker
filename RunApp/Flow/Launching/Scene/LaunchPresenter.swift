//
//  LaunchPresenter.swift
//  RunChecker
//
//  Created by Мария Хатунцева on 22.02.2023.
//

protocol LaunchViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}
protocol LaunchPresenterOutputToView: LaunchViewProtocol {
    func startAnimation()
}

protocol LaunchPresenterInputFromView {
    func viewDidLoad()
}

final class LaunchPresenter: LaunchPresenterInputFromView {

    private weak var view: LaunchPresenterOutputToView?
    private var interactor: LaunchUseCases?

    func setupDependencies(view: LaunchPresenterOutputToView,
                           interactor: LaunchUseCases) {
        self.view = view
        self.interactor = interactor
    }

    func viewDidLoad() {
       
        interactor?.initialSetup(
            completion: { [weak self] _ in
                self?.view?.startAnimation()
            }
        )
    }
    
}
