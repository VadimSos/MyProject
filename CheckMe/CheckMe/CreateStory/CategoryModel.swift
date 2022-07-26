//
//  CategoryModel.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 25.07.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation

enum CategoryModel {
    case category
    case sport
    case gas
    case taxi
    case foot
    case medicine
    case treatment

    var localizedTitle: String {
        switch self {
        case .category: return "Choose category"
        case .sport: return "Sport"
        case .gas: return "Gas"
        case .taxi: return "Taxi"
        case .foot: return "Foot"
        case .medicine: return "Medicine"
        case .treatment: return "Treatment"
        }
    }
}
