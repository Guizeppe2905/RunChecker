//
//  LocationManager.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import Foundation
import CoreLocation

final class LocationManager {
    var manager: CLLocationManager
    
    init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .fitness
    }
    
    func checkLocationAuthorisation() {
        if manager.authorizationStatus != .authorizedWhenInUse {
            manager.requestWhenInUseAuthorization()
        }
    }
}
