//
//  BaseViewController.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    private lazy var backgroundLayer: GradientView = {
        let view = GradientView(colors: [Colors.darkGreen, Colors.primaryTeal, Colors.energyGreen, Colors.teal])
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubview(backgroundLayer)
    }
    
    private func setupConstraints() {
        backgroundLayer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

