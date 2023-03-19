//
//  BaseTableViewSection.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import Foundation

class BaseTableViewSection: TableViewSection {
    var headerItem: TableViewSectionHeaderCompatible?
    var items: [TableViewCompatible]

    init(
        headerItem: TableViewSectionHeaderCompatible? = nil,
        items: [TableViewCompatible]
    ) {
        self.headerItem = headerItem
        self.items = items
    }
}
