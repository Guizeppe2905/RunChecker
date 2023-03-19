//
//  RUNHistoryTableViewCell.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import UIKit

class RUNHistoryTableViewCell: UITableViewCell, Configurable {
    
    static let rUNHistoryTableViewCell = "RUNHistoryTableViewCell"
    internal var model: RUNHistoryTableViewCellModel?
    
    var totalKM :Double = 0.0 {
        didSet {
            kmLabel.text = String(format: "%0.2f", totalKM)
            layoutIfNeeded()
        }
    }
    
    var totalTime: String = "00:00:00" {
        didSet {
            timeLabel.text = totalTime
            layoutIfNeeded()
        }
    }
    
    var entryDate: String = "01/01/2023" {
        didSet {
            dateLabel.text = entryDate
            layoutIfNeeded()
        }
    }
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = Colors.energyGreen.cgColor
        view.layer.borderWidth = 1.5
        view.layer.backgroundColor = UIColor.clear.cgColor
        [
            kmLabel, timeLabel, dateLabel
        ].forEach {
            view.addSubview($0)
        }
        return view
    }()
    
    private lazy var kmLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bosanova(.regular, size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.bosanova(.bold, size: 14)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.bosanova(.regular, size: 14)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.black.withAlphaComponent(0.1)
        initUI()
        initConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        selectionStyle = .default
        addSubview(containerView)
    }
    
    func configure(with model: RUNHistoryTableViewCellModel) {
        self.model = model
        kmLabel.text = model.km
        timeLabel.text = model.time
        dateLabel.text = model.date
    }
    
    private func initConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(45)
        }
        kmLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(containerView).offset(5)
            make.height.equalTo(15)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(kmLabel.snp.bottom).offset(5)
            make.leading.equalTo(kmLabel)
            make.height.equalTo(15)
            make.bottom.equalTo(containerView).offset(-5)
        }
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.trailing.equalTo(containerView).offset(-5)
            make.height.equalTo(15)
        }
    }
}

