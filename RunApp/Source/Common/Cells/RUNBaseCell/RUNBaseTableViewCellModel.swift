//
//  BaseTableViewCellModel.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import UIKit

class RUNBaseTableViewCellModel: TableViewCompatible {
    var selected: Bool
    var title: String
    var value: String
    var subtitle: String
    
    init(title: String,
         value: String,
         subtitle: String,
         selected: Bool) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.selected = selected
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? RUNBaseTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: self)
        return cell
    }
    
    var reuseIdentifier: String {
        String(describing: RUNBaseTableViewCell.self)
    }
}
