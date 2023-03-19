//
//  CurrentRunDataSource.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//


import UIKit
class CurrentRunDataSource: TableViewDataSource {
    
    override init(tableView: UITableView) {
        super.init(tableView: tableView)
        registerCell()
    }
    
    func prepareData() {
        var items = [TableViewCompatible]()
        
        items.append(
            RUNBaseTableViewCellModel(title: "",
                                      value: "БЕЖИМ!",
                                      subtitle: "",
                                      selected: false)
            )
        
        items.append(
            RUNBaseTableViewCellModel(title: "Общее время пробежки",
                                      value: "",
                                      subtitle: "",
                                      selected: false)
            )
        
        items.append(
            RUNBaseTableViewCellModel(title: "Средний темп",
                                      value: "",
                                      subtitle: "/км",
                                      selected: false)
            )
        
        items.append(
            RUNBaseTableViewCellModel(title: "Дистанция",
                                      value: "",
                                      subtitle: "км",
                                      selected: false)
            )
        
        sections.append(
            BaseTableViewSection(
                headerItem: nil,
                items: items
            )
        )
                
        tableView.reloadData()
    }
    
    private func registerCell() {
        tableView.register(RUNBaseTableViewCell.self, forCellReuseIdentifier: "RUNBaseTableViewCell")
    }
}
