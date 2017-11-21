//
//  DayViewViewModelTests.swift
//  WeatherTests
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import XCTest
@testable import Weather

class DayViewViewModelTests: XCTestCase {
    
    var viewModel: DayViewViewModel!
    
    override func setUp() {
        super.setUp()
        let data = loadStubFromBundle(withName: "darksky", ext: "json")
        let weatherData: WeatherData = try! JSONDecoder.decode(data: data)
        viewModel = DayViewViewModel(weatherData: weatherData)
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.timeNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
        super.tearDown()
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Wed, December 21")
    }
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Partly Cloudy")
    }
    
    func testTemperature_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        XCTAssertEqual(viewModel.temperature, "54.1")
    }
    
    func testTemperature_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        XCTAssertEqual(viewModel.temperature, "12.3")
    }
    
    func testWindSpeed_Imperial() {
        let unitNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        XCTAssertEqual(viewModel.windSpeed, "5 MPH")
    }
    
    func testWindSpeed_Metric() {
        let unitNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        XCTAssertEqual(viewModel.windSpeed, "7 KPH")
    }
    
    func testTime_TwelveHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        XCTAssertEqual(viewModel.time, "12:23 AM")
    }
    
    func testTime_TwentyFourHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        XCTAssertEqual(viewModel.time, "00:23")
    }
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = UIImagePNGRepresentation(viewModelImage!)
        let imageDataReference = UIImagePNGRepresentation(UIImage(named: "clear-day")!)!
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage?.size.width, 236.0)
        XCTAssertEqual(viewModelImage?.size.height, 172.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
}
