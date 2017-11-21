//
//  WeatherData.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import Foundation

struct WeatherData {
    let time: Date
    let lat: Double
    let long: Double
    let windSpeed: Double
    let temperature: Double
    let icon: String
    let summary: String
    let dailyData: [WeatherDayData]
}

extension WeatherData: JSONDecodable {
    init(decoder: JSONDecoder) throws {
        self.lat = try decoder.decode(key: "latitude")
        self.long = try decoder.decode(key: "longitude")
        self.dailyData = try decoder.decode(key: "daily.data")
        self.icon = try decoder.decode(key: "currently.icon")
        self.summary = try decoder.decode(key: "currently.summary")
        self.windSpeed = try decoder.decode(key: "currently.windSpeed")
        self.temperature = try decoder.decode(key: "currently.temperature")
        let time: Double = try decoder.decode(key: "currently.time")
        self.time = Date(timeIntervalSince1970: time)
    }
}
