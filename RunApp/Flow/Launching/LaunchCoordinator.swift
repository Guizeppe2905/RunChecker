//
//  LaunchCoordinator.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

protocol LaunchCoordinatorOutput: Coordinatable {
    var finishFlow: CompletionBlock? { get set }
}

final class LaunchCoordinator: BaseCoordinator,
                               LaunchCoordinatorOutput {
    var finishFlow: CompletionBlock?

    private let coordinatorsFactory: LaunchCoordinatorFactory
    private let modulesFactory: LaunchModuleFactory
    
    init(coordinatorsFactory: LaunchCoordinatorFactory,
         modulesFactory: LaunchModuleFactory,
         router: Routable) {
        self.coordinatorsFactory = coordinatorsFactory
        self.modulesFactory = modulesFactory
        super.init(router: router)
    }
    
    func start() {
        performFlow()
    }
    
    private func performFlow() {
        let view = modulesFactory.makeLaunching()
        router.setRootModule(view,
                             hideNavigationBar: true,
                             rootAnimated: false)
        view.onCompletion = { [weak self] in
            self?.finishFlow?()
        }
    }
    
}
