//
//  SettingsViewUnitsViewModelTests.swift
//  WeatherTests
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import XCTest
@testable import Weather

class SettingsViewUnitsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
        super.tearDown()
    }
    
    func testText_Imperial() {
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .imperial)
        XCTAssertEqual(viewModel.text, "Imperial")
    }
    
    func testText_Metric() {
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .metric)
        XCTAssertEqual(viewModel.text, "Metric")
    }
    
    func testAccessoryType_Imperial_Imperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .imperial)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
    
    func testAccessoryType_Imperial_Metric() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .metric)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_Metric_Imperial() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .imperial)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_Metric_Metric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .metric)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
}
