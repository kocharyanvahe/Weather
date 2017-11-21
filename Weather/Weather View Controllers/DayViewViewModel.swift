//
//  DayViewViewModel.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

struct DayViewViewModel {
    
    let weatherData: WeatherData
    private let dateFormatter = DateFormatter()
    
    func day(for index: Int) -> String {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: weatherData.time)
    }
    
    var date: String {
        dateFormatter.dateFormat = "EEE, MMMM d"
        return dateFormatter.string(from: weatherData.time)
    }
    
    var time: String {
        dateFormatter.dateFormat = UserDefaults.timeNotation().timeFormat
        return dateFormatter.string(from: weatherData.time)
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var temperature: String {
        let temperature = weatherData.temperature
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format: "%.1f", temperature)
        case .celsius:
            return String(format: "%.1f", temperature.toCelcius())
        }
    }
    
    var windSpeed: String {
        let windSpeed = weatherData.windSpeed
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format: "%.f MPH", windSpeed)
        case .metric:
            return String(format: "%.f KPH", windSpeed.toKPH())
        }
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(withName: weatherData.icon)
    }
}
