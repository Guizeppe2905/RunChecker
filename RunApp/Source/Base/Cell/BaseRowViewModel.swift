//
//  BaseRowViewModel.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import Foundation
import UIKit

class BaseRowViewModel: RowViewModel {
    var cellClass: AnyClass
    var cellIdentifier: String
    var object: Any
    var isLoadFromNib: Bool
    
    init(_ cell: UITableViewCell.Type, object: Any, isLoadFromNib: Bool = false) {
        self.cellClass = cell
        self.cellIdentifier = cell.cellIdentifier()
        self.object = object
        self.isLoadFromNib = isLoadFromNib
    }
}
