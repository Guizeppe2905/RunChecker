//
//  HistoryInteractor.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

final class HistoryInteractor: HistoryPresenterOutputToInteractor {
    
    private weak var presenter: HistoryPresenterInputFromInteractor?
    
    func setupDependencies(presenter: HistoryPresenterInputFromInteractor) {
        self.presenter = presenter
    }
    
}

