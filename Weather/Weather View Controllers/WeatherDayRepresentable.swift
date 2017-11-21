//
//  WeatherDayRepresentable.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

protocol WeatherDayRepresentable {
    var day: String { get }
    var date: String { get }
    var windSpeed: String { get }
    var temperature: String { get }
    var image: UIImage? { get }
}
