//
//  CellStruct.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

struct CellStruct {
    var identifier: CellIdentifier
    var object: Any?
    
    init(_ identifier: CellIdentifier, _ object: Any? = nil) {
        self.identifier = identifier
        self.object = object
    }
}
