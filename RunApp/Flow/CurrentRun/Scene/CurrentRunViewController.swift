//
//  CurrentRunViewController.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit
import SnapKit
import CoreLocation
import RealmSwift

class CurrentRunViewController: BaseViewController, CurrentRunAssemblable {
    
    private var presenter: CurrentRunPresenterInputFromView?
    internal var dataSource: CurrentRunDataSource?
    var onCompletion: CompletionBlock?
    
    private var startLocation: CLLocation?
    private var endLocation: CLLocation?
    
    private var runDistance = 0.0
    private var timeElapsed = 0
    private var pace = 0
    fileprivate var coorLocations = List<Location>()
    
    private var locationManager = LocationManager()
    
    private var timer = Timer()
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 25
        tv.backgroundColor = .clear
        return tv
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.bosanova(.bold, size: 20)
        label.textAlignment = .center
        label.text = "00:00:00"
        return label
    }()
    
    private lazy var paceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0:00"
        label.textAlignment = .center
        label.font = UIFont.bosanova(.bold, size: 20)
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0.0"
        label.textAlignment = .center
        label.font = UIFont.bosanova(.bold, size: 20)
        return label
    }()
    
    private lazy var slider: SliderView = {
       let view = SliderView()
        view.isUserInteractionEnabled = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.manager.delegate = self
        startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopRunning()
    }
    
    func setupDependencies(presenter: CurrentRunPresenterInputFromView) {
        self.presenter = presenter
    }
    
    private func setupViews() {
        [
            timeLabel, paceLabel, distanceLabel,
            slider, tableView
        ].forEach {
            view.addSubview($0)
        }
        let swipeGesture = UIPanGestureRecognizer(target: self,
                                                  action: #selector(dismissEnd(sender:)))
        slider.stopSliderKnob.addGestureRecognizer(swipeGesture)
        
        dataSource = CurrentRunDataSource(
            tableView: tableView
        )
        self.prepareData()
        presenter?.onStart()
    }
    
    private func setupConstraints() {

        tableView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(430)
        }
        timeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(tableView).offset(175)
            make.height.equalTo(15)
        }
        paceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(60)
            make.height.equalTo(40)
        }
        distanceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(paceLabel.snp.bottom).offset(55)
            make.height.equalTo(40)
        }
        slider.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(56)
            make.top.equalTo(tableView.snp.bottom).offset(50)
        }
    }
    
    private func startRunning() {
        locationManager.manager.startUpdatingLocation()
        startTimer()
    }
    
    private func stopRunning() {
        locationManager.manager.stopUpdatingLocation()
        stopTimer()
    }
    
    private func startTimer(){
        timeLabel.text = timeElapsed.formateTimeString()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    private func stopTimer(){
        timer.invalidate()
        timeElapsed = 0
    }
    
    @objc private func updateTimer(){
        timeElapsed += 1
        timeLabel.text = timeElapsed.formateTimeString()
    }
    
    @objc private func dismissEnd(sender: UIPanGestureRecognizer) {
        let adjust: CGFloat = 35
        let translation = sender.translation(in: view)
    
        if sender.state == .began || sender.state == .changed {
            if slider.stopSliderKnob.center.x > slider.sliderStop.center.x {
                slider.stopSliderKnob.center.x = slider.sliderStop.center.x
                let timeElapsed = self.timeElapsed
                stopRunning()
                Run.addRunToRealm(pace: pace,
                                  distance: runDistance,
                                  duration: timeElapsed,
                                  locations: coorLocations)
                dismiss(animated: true)
            } else if slider.stopSliderKnob.center.x < slider.capsuleView.bounds.minX + adjust {
                slider.stopSliderKnob.center.x = slider.capsuleView.bounds.minX + adjust
            } else {
                slider.stopSliderKnob.center.x += translation.x
            }
                sender.setTranslation(.zero, in: view)
        } else if sender.state == .ended && slider.stopSliderKnob.center.x < slider.sliderStop.center.x {
                UIView.animate(withDuration: 0.5) {
                    self.slider.stopSliderKnob.center.x = self.slider.capsuleView.bounds.minX + adjust
            }
        }
    }
    
    private func computePace(time seconds: Int, km: Double) -> String {
        pace = Int(Double(seconds) / km)
        return pace.formateTimeString()
    }
}
    
extension CurrentRunViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            guard let loc = endLocation?.distance(from: location) else {
                return
            }
            runDistance += loc
            let newLocation = Location(lat: Double(endLocation?.coordinate.latitude ?? 0.0),
                                       long: Double(endLocation?.coordinate.longitude ?? 0.0))
            coorLocations.insert(newLocation, at: 0)
            self.distanceLabel.text = self.runDistance.meterTokm().toString(places: 2)
    
            if timeElapsed > 0 && runDistance > 0 {
                paceLabel.text = computePace(time: timeElapsed, km: runDistance.meterTokm())
            }
        }
        endLocation = locations.last
    }
}
    
extension CurrentRunViewController {
    func prepareData() {
        guard let dS = dataSource else { return }
        dS.prepareData()
    }
}

