//
//  WeatherDayViewViewModel.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

struct WeatherDayViewViewModel {
    
    let weatherDayData: WeatherDayData
    private let formatter = DateFormatter()
    
    var day: String {
        formatter.dateFormat = "EEEE"
        return formatter.string(from: weatherDayData.time)
    }
    
    var date: String {
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: weatherDayData.time)
    }
    
    var temperature: String {
        let min = format(temperature: weatherDayData.temperatureMin)
        let max = format(temperature: weatherDayData.temperatureMax)
        return "\(min) - \(max)"
    }
    
    var windSpeed: String {
        let windSpeed = weatherDayData.windSpeed
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format: "%.f MPH", windSpeed)
        case .metric:
            return String(format: "%.f KPH", windSpeed.toKPH())
        }
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(withName: weatherDayData.icon)
    }
    
    private func format(temperature: Double) -> String {
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format: "%.0f", temperature)
        case .celsius:
            return String(format: "%.0f", temperature.toCelcius())
        }
    }
}

extension WeatherDayViewViewModel: WeatherDayRepresentable {
    
}
