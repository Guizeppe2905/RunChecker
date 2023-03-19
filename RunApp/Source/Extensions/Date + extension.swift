//
//  Date + extension.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

extension Date {
    func getDateString() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        
        return "\(day).\(month).\(year)"
    }
}
