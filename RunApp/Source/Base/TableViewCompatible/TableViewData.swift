//
//  TableViewData.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import UIKit

public protocol TableViewData {
    
    var sections: [TableViewSection] { get set }
    var skeletonReuseIdentifier: String { get set }
    
    subscript(indexPath: IndexPath) -> TableViewCompatible { get set }
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func cellForTableView(tableView: UITableView, atIndexPath: IndexPath) -> UITableViewCell
    func headerForTableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    
}

public extension TableViewData {
    subscript(indexPath: IndexPath) -> TableViewCompatible {
        get {
            sections[indexPath.section].items[indexPath.row]
        }
        set {
            var items = sections[indexPath.section].items
            items.insert(newValue, at: indexPath.row)
        }
    }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        sections[section].items.count
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let model = self[indexPath]
        return model.cellForTableView(tableView: tableView, atIndexPath: indexPath)
    }
    
    func headerForTableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        sections[section].headerItem?.headerForTableView(tableView: tableView, viewForHeaderInSection: section)
    }
}
