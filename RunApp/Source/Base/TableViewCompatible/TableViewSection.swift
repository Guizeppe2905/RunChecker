//
//  TableViewSection.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import UIKit

public protocol TableViewSection {
    
    var headerItem: TableViewSectionHeaderCompatible? { get set }
    var items: [TableViewCompatible] { get set }
    
}
