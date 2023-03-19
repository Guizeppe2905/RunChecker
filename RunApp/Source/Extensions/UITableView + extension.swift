//
//  UITableView + extension.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//
import UIKit

extension UITableView {
    func register(with rowViewModels: [BaseRowViewModel]) {
        for model in rowViewModels {
            if model.isLoadFromNib {
                self.register(
                    UINib(nibName: String(describing: model.cellClass), bundle: nil),
                    forCellReuseIdentifier: model.cellIdentifier
                )
            } else {
                self.register(model.cellClass, forCellReuseIdentifier: model.cellIdentifier)
            }
        }
    }
    
    func register(with prototypeCellIdentifiers: [CellIdentifier]) {
        for cellIdentifier in prototypeCellIdentifiers {
            self.register(
                UINib(nibName: cellIdentifier.cell, bundle: nil), forCellReuseIdentifier: cellIdentifier.cellIdentifier
            )
        }
    }
    
    func register(with cellStructs: [CellStruct]) {
        for cell in cellStructs {
            register(for: cell)
        }
    }
    
    func register(with sectionStructs: [SectionStruct]) {
        for section in sectionStructs {
            for cell in section.cells {
                register(for: cell)
            }
        }
    }
    
    private func register(for cell: CellStruct) {
        switch cell.identifier {
        case .runBaseTableViewCell:
            self.register(RUNBaseTableViewCell.self, forCellReuseIdentifier: cell.identifier.cellIdentifier)
        default:
            self.register(
                UINib(nibName: cell.identifier.cell, bundle: nil), forCellReuseIdentifier: cell.identifier.cellIdentifier
            )
        }
    }
}
