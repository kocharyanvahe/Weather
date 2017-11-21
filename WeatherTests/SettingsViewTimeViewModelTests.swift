//
//  SettingsViewTimeViewModelTests.swift
//  WeatherTests
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import XCTest
@testable import Weather

class SettingsViewTimeViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.timeNotation)
        super.tearDown()
    }
    
    func testText_TwelveHour() {
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twelveHour)
        XCTAssertEqual(viewModel.text, "12 Hour")
    }
    
    func testText_TwentyFourHour() {
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twentyFourHour)
        XCTAssertEqual(viewModel.text, "24 Hour")
    }
    
    func testAccessoryType_TwelveHour_TwelveHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twelveHour)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
    
    func testAccessoryType_TwelveHour_TwentyFourHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twentyFourHour)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_TwentyFourHour_TwelveHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twelveHour)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_TwentyFourHour_TwentyFourHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twentyFourHour)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
}
