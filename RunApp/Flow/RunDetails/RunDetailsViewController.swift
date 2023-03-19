//
//  RunDetailsViewController.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit
import MapKit

class RunDetailsViewController: BaseViewController, RunDetailsAssemblable {

    var onCompletion: CompletionBlock?
    var run: Run
    private var presenter: RunDetailsPresenterInputFromView?
    
    private lazy var mapView: MKMapView = {
       let view = MKMapView()
        view.alpha = 0.6
        view.delegate = self
        return view
    }()
    
    private lazy var topHandleBack: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.darkGreen.withAlphaComponent(0.4)
        return view
    }()
    
    private lazy var topHandle: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.energyGreen.withAlphaComponent(0.6)
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    init(run: Run) {
        self.run = run
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setMapOverlay()
    }
    
    func setupDependencies(presenter: RunDetailsPresenterInputFromView) {
        self.presenter = presenter
    }
    
    private func setupViews() {
        view.addSubview(mapView)
        view.addSubview(topHandleBack)
        topHandleBack.addSubview(topHandle)
    }
    
    private func setMapOverlay() {
        if mapView.overlays.count > 0 {
            mapView.removeOverlays(mapView.overlays)
        }
        
        mapView.addOverlay(getPolyline(from: run))
        mapView.setRegion(centerMap(run: run), animated: true)
        
        let startPoint = MKPointAnnotation()
        startPoint.title = "Старт"
        let startLoc = run.locations[run.locations.count - 1]
        startPoint.coordinate = CLLocationCoordinate2D(latitude: startLoc.latitude,
                                                       longitude: startLoc.longitude)
        mapView.addAnnotation(startPoint)
        
        let endPoint = MKPointAnnotation()
        endPoint.title = "Финиш"
        let endLoc = run.locations[0]
        endPoint.coordinate = CLLocationCoordinate2D(latitude: endLoc.latitude,
                                                       longitude: endLoc.longitude)
        mapView.addAnnotation(endPoint)
    }
    
    private func centerMap(run: Run) -> MKCoordinateRegion {
        guard let (minLoc, maxLoc) = getMinMaxLocationCoordinates(run: run) else {
            return MKCoordinateRegion()
        }
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLoc.latitude + maxLoc.latitude) / 2,
                                                                 longitude: (minLoc.longitude + maxLoc.longitude) / 2),
                                  span: MKCoordinateSpan(latitudeDelta: (maxLoc.latitude - minLoc.latitude) * 1.5,
                                                         longitudeDelta: (maxLoc.longitude - minLoc.longitude) * 1.5))
    }
    
    private func getMinMaxLocationCoordinates(run: Run) -> (min: CLLocationCoordinate2D,
                                                            max: CLLocationCoordinate2D)? {
        let locations = run.locations
        
        guard let firstLocation = locations.first else {
            return nil
        }
        
        var minLat = firstLocation.latitude
        var minLong = firstLocation.longitude
        
        var maxLat = minLat
        var maxLong = minLong
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLong = min(minLong, location.longitude)
            
            maxLat = max(maxLat, location.latitude)
            maxLong = max(maxLong, location.longitude)
        }
        return (min: CLLocationCoordinate2D(latitude: minLat, longitude: minLong),
                max: CLLocationCoordinate2D(latitude: maxLat, longitude: maxLong))
    }
    
    private func getPolyline(from run: Run) -> MKPolyline {
        var coord = [CLLocationCoordinate2D]()
        for location in run.locations {
            coord.append(CLLocationCoordinate2D(latitude: location.latitude,
                                                longitude: location.longitude))
        }
        return MKPolyline(coordinates: coord, count: run.locations.count)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        topHandleBack.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(20)
        }
        topHandle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(6)
        }
    }
}

extension RunDetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4
        return renderer
    }
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let identifier = "mapAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKPinAnnotationView
       
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation,
                                                 reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        if annotation.title == "Старт" {
            annotationView?.pinTintColor = UIColor.red
        } else if annotation.title == "Финиш" {
            annotationView?.pinTintColor = UIColor.green
        }
        
        return annotationView
    }
}
