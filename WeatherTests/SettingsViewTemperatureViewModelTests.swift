//
//  SettingsViewTemperatureViewModelTests.swift
//  WeatherTests
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import XCTest
@testable import Weather

class SettingsViewTemperatureViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
        super.tearDown()
    }
    
    func testText_Fahrenheit() {
        let viewModel = SettingViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.text, "Fahrenheit")
    }
    
    func testText_Celsius() {
        let viewModel = SettingViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.text, "Celsius")
    }
    
    func testAccessoryType_Fahrenheit_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
    
    func testAccessoryType_Fahrenheit_Celsius() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_Celsius_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_Celsius_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
}
