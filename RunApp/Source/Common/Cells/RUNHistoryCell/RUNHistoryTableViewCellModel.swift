//
//  RUNHistoryTableViewCellModel.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import UIKit

class RUNHistoryTableViewCellModel: TableViewCompatible {
    var selected: Bool
    var km: String
    var time: String
    var date: String
    
    init(km: String,
         time: String,
         date: String,
         selected: Bool) {
        self.km = km
        self.time = time
        self.date = date
        self.selected = selected
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? RUNHistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: self)
        return cell
    }
    
    var reuseIdentifier: String {
        String(describing: RUNHistoryTableViewCell.self)
    }
}


