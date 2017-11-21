//
//  SettingsRepresentable.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

protocol SettingsRepresentable {
    var text: String { get }
    var accessoryType: UITableViewCellAccessoryType { get }
}
