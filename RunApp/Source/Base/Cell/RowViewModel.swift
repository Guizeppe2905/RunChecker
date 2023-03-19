//
//  RowViewModel.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//

import Foundation

protocol RowViewModel {
    var cellClass: AnyClass { get set }
    var cellIdentifier: String { get set }
}
