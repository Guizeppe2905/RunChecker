//
//  CellIdentifier.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import UIKit

enum CellIdentifier: String {
    
    case runBaseTableViewCell = "RUNBaseTableViewCell"
    
    var cellIdentifier: String {
        switch self {
        case .runBaseTableViewCell:
            return String(describing: RUNBaseTableViewCell.self)
        default:
            return self.rawValue + "CellIdentifier"
        }
    }
    
    var cell: String {
        "RUN" + self.rawValue + "TableViewCell"
    }
}
