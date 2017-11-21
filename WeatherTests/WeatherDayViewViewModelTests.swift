//
//  WeatherDayViewViewModelTests.swift
//  WeatherTests
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherDayViewViewModelTests: XCTestCase {
    
    var viewModel: WeatherDayViewViewModel!
    
    override func setUp() {
        super.setUp()
        let data = loadStubFromBundle(withName: "darksky", ext: "json")
        let weatherData: WeatherData = try! JSONDecoder.decode(data: data)
        viewModel = WeatherDayViewViewModel(weatherDayData: weatherData.dailyData[5])
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
        super.tearDown()
    }
    
    func testDay() {
        XCTAssertEqual(viewModel.day, "Sunday")
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "December 25")
    }
    
    func testTemperature_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        XCTAssertEqual(viewModel.temperature, "41 - 54")
    }
    
    func testTemperature_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        XCTAssertEqual(viewModel.temperature, "5 - 12")
    }
    
    func testWindSpeed_Imperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        XCTAssertEqual(viewModel.windSpeed, "2 MPH")
    }
    
    func testWindSpeed_Metric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        XCTAssertEqual(viewModel.windSpeed, "4 KPH")
    }
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = UIImagePNGRepresentation(viewModelImage!)
        let imageDataReference = UIImagePNGRepresentation(UIImage(named: "cloudy")!)!
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 173.0)
        XCTAssertEqual(viewModelImage!.size.height, 174.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
}
