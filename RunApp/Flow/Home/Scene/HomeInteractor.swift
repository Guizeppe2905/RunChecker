//
//  HomeInteractor.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

final class HomeInteractor: HomePresenterOutputToInteractor {
    
    private weak var presenter: HomePresenterInputFromInteractor?
    
    func setupDependencies(presenter: HomePresenterInputFromInteractor) {
        self.presenter = presenter
    }
    
}
