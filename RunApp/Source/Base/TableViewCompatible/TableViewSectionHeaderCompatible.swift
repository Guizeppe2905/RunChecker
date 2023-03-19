//
//  TableViewSectionHeaderCompatible.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import Foundation
import UIKit

public protocol TableViewSectionHeaderCompatible {
    
    var reuseIdentifier: String { get }
    
    func headerForTableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    
}
