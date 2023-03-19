//
//  HomeViewController.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit
import MapKit

class HomeViewController: BaseViewController, HomeAssemblable {
    
    private var presenter: HomePresenterInputFromView?
    private var locationManager = LocationManager()
    
    func setupDependencies(presenter: HomePresenterInputFromView) {
        self.presenter = presenter
    }
    
    private lazy var startButton: CircularButton = {
      let button = CircularButton()
        button.borderWidth = 15
        button.borderColor = Colors.darkGreen
        button.titleText = "Бежать"
        button.addTarget(self, action: #selector(startRunning), for: .touchUpInside)
        return button
    }()
    
    private lazy var topLabel: UILabel = {
       let label = UILabel()
        label.text = "Приятной пробежки"
        label.textAlignment = .center
        label.textColor = Colors.lightSand
        label.font = UIFont.bosanova(.bold, size: 30)
        return label
    }()
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.alpha = 0.6
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        locationManager.checkLocationAuthorisation()
        [
            topLabel, mapView, startButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    @objc private func startRunning() {
        let vc = CurrentRunViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func setupConstraints() {
        topLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(Utils.safeAreaInsets.top)
            make.height.equalTo(80)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(8)
            make.bottom.equalTo(Utils.safeAreaInsets.bottom)
            make.trailing.leading.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(Utils.safeAreaInsets.bottom).offset(-100)
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}
