//
//  HistoryDataSource.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import UIKit
import Foundation

class HistoryDataSource: TableViewDataSource {
    
    private var presenter: HistoryPresenterInputFromView?
    
    override init(tableView: UITableView) {
        super.init(tableView: tableView)
        registerCell()
    }
    
    func prepareData() {
        var items = [TableViewCompatible]()
        items.removeAll()
        items.append(
            RUNBaseTableViewCellModel(title: "",
                                      value: "История пробежек",
                                      subtitle: "",
                                      selected: false)
            )

        let logs = Run.getAllRuns()
        if logs?.count == 0 {
            items.append(
                RUNHistoryTableViewCellModel(km: "У вас пока 0 записанных пробежек",
                                             time: "Сегодня отличный день начать!",
                                             date: "",
                                             selected: false)
                )
        } else {
            guard let allLogs = logs else { return }
            for (_, item) in allLogs.enumerated() {
                let kmItem = String(format: "%0.2f", item.distance.meterTokm())
                items.append(
                    RUNHistoryTableViewCellModel(km: "\(kmItem) км",
                                                 time: item.duration.formateTimeString(),
                                                 date: item.date.getDateString(),
                                                 selected: false)
                    )
            }
        }
        
        sections.append(
            BaseTableViewSection(
                headerItem: nil,
                items: items
            )
        )
                
        tableView.reloadData()
    }
    
    private func registerCell() {
        tableView.register(RUNHistoryTableViewCell.self, forCellReuseIdentifier: "RUNHistoryTableViewCell")
        tableView.register(RUNBaseTableViewCell.self, forCellReuseIdentifier: "RUNBaseTableViewCell")
    }
}
