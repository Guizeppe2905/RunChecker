//
//  CurrentRunCoordinator.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol CurrentRunCoordinatorOutput: Coordinatable {
    var finishFlow: CompletionBlock? { get set }
}

final class CurrentRunCoordinator: BaseCoordinator,
                                   CurrentRunCoordinatorOutput {
    var finishFlow: CompletionBlock?

    private let coordinatorsFactory: CurrentRunCoordinatorFactory
    private let modulesFactory: CurrentRunModuleFactory
    
    init(coordinatorsFactory: CurrentRunCoordinatorFactory,
         modulesFactory: CurrentRunModuleFactory,
         router: Routable) {
        self.coordinatorsFactory = coordinatorsFactory
        self.modulesFactory = modulesFactory
        super.init(router: router)
    }
    
    func start() {
        performFlow()
    }
    
    private func performFlow() {
        let view = modulesFactory.makeCurrentRun()
        router.setRootModule(view,
                             hideNavigationBar: true,
                             rootAnimated: false)
    }
    
}


