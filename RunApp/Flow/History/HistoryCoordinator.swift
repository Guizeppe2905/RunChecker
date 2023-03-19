//
//  HistoryCoordinator.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol HistoryCoordinatorOutput: Coordinatable {
    var finishFlow: CompletionBlock? { get set }
}

final class HistoryCoordinator: BaseCoordinator,
                                HistoryCoordinatorOutput {
    var finishFlow: CompletionBlock?

    private let coordinatorsFactory: HistoryCoordinatorFactory
    private let modulesFactory: HistoryModuleFactory
    
    init(coordinatorsFactory: HistoryCoordinatorFactory,
         modulesFactory: HistoryModuleFactory,
         router: Routable) {
        self.coordinatorsFactory = coordinatorsFactory
        self.modulesFactory = modulesFactory
        super.init(router: router)
    }
    
    func start() {
        performFlow()
    }
    
    private func performFlow() {
        let view = modulesFactory.makeHistory()
        router.setRootModule(view,
                             hideNavigationBar: true,
                             rootAnimated: false)
    }
    
}

