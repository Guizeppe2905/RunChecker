//
//  SectionStruct.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

struct SectionStruct {
    var object: Any?
    var cells: [CellStruct]
    
    init(_ object: Any?, _ cells: [CellStruct]) {
        self.object = object
        self.cells = cells
    }
}
