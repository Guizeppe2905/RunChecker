//
//  TableViewDataSource.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import UIKit

import UIKit
import SkeletonView

open class TableViewDataSource: NSObject, TableViewData, SkeletonTableViewDataSource {
    
    public var skeletonReuseIdentifier: String
    public let tableView: UITableView
    open var sections: [TableViewSection] = []
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        self.skeletonReuseIdentifier = ""
        super.init()
        tableView.dataSource = self
    }
    
    public init(tableView: UITableView, skeletonReuseIdentifier: String) {
        self.tableView = tableView
        self.skeletonReuseIdentifier = skeletonReuseIdentifier
        super.init()
        tableView.dataSource = self
    }
    
    open func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        skeletonReuseIdentifier
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRowsInSection(section: section)
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellForTableView(tableView: tableView, atIndexPath: indexPath)
    }

    
    open func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSections()
    }
    
    open func insertItem(atIndexPath indexPath: IndexPath) {
        // Override in subclass if needed
    }
    
    open func deleteItem(atIndexPath indexPath: IndexPath) {
        self.sections[indexPath.section].items.remove(at: indexPath.row)
    }
}

extension TableViewDataSource: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        sections[section].headerItem?.headerForTableView(tableView: tableView, viewForHeaderInSection: section)
    }
    
}
