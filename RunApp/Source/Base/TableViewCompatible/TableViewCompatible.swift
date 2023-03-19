//
//  TableViewCompatible.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import Foundation
import UIKit

public protocol TableViewCompatible: CollectionAndTableViewCompatible {
    var reuseIdentifier: String { get }
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
}
