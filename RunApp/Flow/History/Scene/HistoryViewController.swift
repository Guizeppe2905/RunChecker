//
//  HistoryViewController.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit
import RealmSwift
import Realm

class HistoryViewController: BaseViewController, HistoryAssemblable {
    
    private var presenter: HistoryPresenterInputFromView?
    internal var dataSource: HistoryDataSource?
    var onCompletion: CompletionBlock?
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 25
        tv.backgroundColor = .clear
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        setupConstraints()
    }
    
    func setupDependencies(presenter: HistoryPresenterInputFromView) {
        self.presenter = presenter
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.delegate = self
        dataSource = HistoryDataSource(
            tableView: tableView
        )
        self.prepareData()
        presenter?.onStart()
    }

    private func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
}

extension HistoryViewController {
    func prepareData() {
        guard let dS = dataSource else { return }
        dS.prepareData()
    }
}
