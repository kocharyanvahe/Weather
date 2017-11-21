//
//  SettingsViewUnitsViewModel.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

struct SettingsViewUnitsViewModel {
    let unitsNotation: UnitsNotation
    
    var text: String {
        switch unitsNotation {
        case .imperial:
            return "Imperial"
        case .metric:
            return "Metric"
        }
    }
    
    var accessoryType: UITableViewCellAccessoryType {
        if UserDefaults.unitsNotation() == unitsNotation {
            return .checkmark
        } else {
            return .none
        }
    }
}

extension SettingsViewUnitsViewModel: SettingsRepresentable {
    
}
