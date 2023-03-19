//
//  Configurable.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

public protocol Configurable {
    
    associatedtype T
    var model: T? { get set }
    func configure(with model: T)
    
}
