//
//  CurrentRunPresenter.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol CurrentRunViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}
protocol CurrentRunPresenterOutputToView: CurrentRunViewProtocol {
    func prepareData()
}
protocol CurrentRunPresenterOutputToInteractor { }

protocol CurrentRunPresenterInputFromInteractor: AnyObject { }
protocol CurrentRunPresenterInputFromView {
    func onStart()
}

final class CurrentRunPresenter: CurrentRunPresenterInputFromView,
                                 CurrentRunPresenterInputFromInteractor {

    private weak var view: CurrentRunPresenterOutputToView?
    private var interactor: CurrentRunPresenterOutputToInteractor?
    private weak var output: CurrentRunPresenterOutputToView?

    func setupDependencies(view: CurrentRunPresenterOutputToView,
                           interactor: CurrentRunPresenterOutputToInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func onStart() {
        output?.prepareData()
    }
}
