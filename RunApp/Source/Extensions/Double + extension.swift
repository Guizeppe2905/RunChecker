//
//  Double + extension.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import Foundation

extension Double {
    func meterTokm() -> Double {
        let meters = Measurement(value: self, unit: UnitLength.meters)
        return meters.converted(to: .kilometers).value
    }
    
    func toString(places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}
