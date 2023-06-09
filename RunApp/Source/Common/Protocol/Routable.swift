//
//  Routable.swift
//  RunChecker
//
//  Created by Мария Хатунцева on 22.02.2023.
//  
//

import Foundation

protocol Routable: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, animated: Bool, completion: @escaping (() -> Void))
    func presentOverfullscreen(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: CompletionBlock?)
    
    func setRootModule(_ module: Presentable?, rootAnimated: Bool)
    func setRootModule(_ module: Presentable?, hideNavigationBar: Bool, rootAnimated: Bool)
    
    func popToRootModule(animated: Bool)
    
}
