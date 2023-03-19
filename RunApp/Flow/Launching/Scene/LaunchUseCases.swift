//
//  LaunchUseCases.swift
//  RunChecker
//
//  Created by Мария Хатунцева on 22.02.2023.
//

protocol LaunchUseCases {
    func initialSetup(
        completion: @escaping CompletionResult<Result<Void, Error>>
    )
}
