//
//  HistoryPresenter.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

protocol HistoryViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}
protocol HistoryPresenterOutputToView: HistoryViewProtocol {
    func prepareData()
}
protocol HistoryPresenterOutputToInteractor { }

protocol HistoryPresenterInputFromInteractor: AnyObject { }
protocol HistoryPresenterInputFromView {
    func onStart()
}

final class HistoryPresenter: HistoryPresenterInputFromView,
                              HistoryPresenterInputFromInteractor {

    private weak var view: HistoryPresenterOutputToView?
    private var interactor: HistoryPresenterOutputToInteractor?
    private weak var output: HistoryPresenterOutputToView?

    func setupDependencies(view: HistoryPresenterOutputToView,
                           interactor: HistoryPresenterOutputToInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func onStart() {
        output?.prepareData()
    }
}
