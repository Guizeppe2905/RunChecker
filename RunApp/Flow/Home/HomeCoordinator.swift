//
//  HomeCoordinator.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol HomeCoordinatorOutput: Coordinatable {
    var finishFlow: CompletionBlock? { get set }
}

final class HomeCoordinator: BaseCoordinator,
                             HomeCoordinatorOutput {
    var finishFlow: CompletionBlock?

    private let coordinatorsFactory: HomeCoordinatorFactory
    private let modulesFactory: HomeModuleFactory
    
    init(coordinatorsFactory: HomeCoordinatorFactory,
         modulesFactory: HomeModuleFactory,
         router: Routable) {
        self.coordinatorsFactory = coordinatorsFactory
        self.modulesFactory = modulesFactory
        super.init(router: router)
    }
    
    func start() {
        performFlow()
    }
    
    private func performFlow() {
        let view = modulesFactory.makeHome()
        router.setRootModule(view,
                             hideNavigationBar: true,
                             rootAnimated: false)
    }
    
}
