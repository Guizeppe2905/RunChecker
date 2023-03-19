//
//  CollectionAndTableViewCompatible.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//


import Foundation

public protocol CollectionAndTableViewCompatible {
    
    var reuseIdentifier: String { get }
    
    var selected: Bool { get set }
    var editable: Bool { get }
    var movable: Bool { get }
    
    func prefetch()
    func cancelPrefetch()

}

public extension CollectionAndTableViewCompatible {
    
    var editable: Bool {
        false
    }
    
    var movable: Bool {
        false
    }
    
    func prefetch() { }
    func cancelPrefetch() { }
    
}
