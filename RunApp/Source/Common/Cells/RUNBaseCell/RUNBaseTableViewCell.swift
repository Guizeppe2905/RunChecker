//
//  RUNBaseTableViewCell.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import UIKit

class RUNBaseTableViewCell: UITableViewCell, Configurable {
    
    static let rUNBaseTableViewCell = "RUNBaseTableViewCell"
    internal var model: RUNBaseTableViewCellModel?
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = Colors.energyGreen.cgColor
        view.layer.borderWidth = 1.5
        view.layer.backgroundColor = UIColor.clear.cgColor
        [
            titleLabel, valueLabel, subtitleLabel
        ].forEach {
            view.addSubview($0)
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bosanova(.regular, size: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.bosanova(.bold, size: 20)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.bosanova(.regular, size: 20)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        initUI()
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
    
    func configure(with model: RUNBaseTableViewCellModel) {
        self.model = model
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        valueLabel.text = model.value
    }
    
    private func initConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(95)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(5)
            make.centerX.equalTo(containerView)
            make.height.equalTo(15)
        }
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(containerView)
            make.height.equalTo(15)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(10)
            make.centerX.equalTo(containerView)
            make.height.equalTo(15)
            make.bottom.equalTo(containerView).offset(-5)
        }
    }
}
