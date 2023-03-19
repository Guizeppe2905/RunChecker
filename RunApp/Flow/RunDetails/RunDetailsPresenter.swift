//
//  RunDetailsPresenter.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol RunDetailsViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}
protocol RunDetailsPresenterOutputToView: RunDetailsViewProtocol {
}
protocol RunDetailsPresenterOutputToInteractor { }

protocol RunDetailsPresenterInputFromInteractor: AnyObject { }
protocol RunDetailsPresenterInputFromView {
}

final class RunDetailsPresenter: RunDetailsPresenterInputFromView,
                                 RunDetailsPresenterInputFromInteractor {

    private weak var view: RunDetailsPresenterOutputToView?
    private var interactor: RunDetailsPresenterOutputToInteractor?
    private weak var output: RunDetailsPresenterOutputToView?

    func setupDependencies(view: RunDetailsPresenterOutputToView,
                           interactor: RunDetailsPresenterOutputToInteractor) {
        self.view = view
        self.interactor = interactor
    }
}
