//
//  WeekViewViewModel.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

struct WeekViewViewModel {
    
    let weatherData: [WeatherDayData]
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    func viewModel(for index: Int) -> WeatherDayViewViewModel {
        return WeatherDayViewViewModel(weatherDayData: weatherData[index])
    }
}
