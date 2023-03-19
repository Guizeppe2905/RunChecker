//
//  HomePresenter.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol HomeViewProtocol: BaseViewProtocol {}
protocol HomePresenterOutputToView: HomeViewProtocol { }
protocol HomePresenterOutputToInteractor { }

protocol HomePresenterInputFromInteractor: AnyObject { }
protocol HomePresenterInputFromView { }

final class HomePresenter: HomePresenterInputFromView,
                           HomePresenterInputFromInteractor {

    private weak var view: HomePresenterOutputToView?
    private var interactor: HomePresenterOutputToInteractor?

    func setupDependencies(view: HomePresenterOutputToView,
                           interactor: HomePresenterOutputToInteractor) {
        self.view = view
        self.interactor = interactor
    }
}

