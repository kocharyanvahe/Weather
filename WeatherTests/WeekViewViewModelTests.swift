//
//  WeekViewViewModelTests.swift
//  WeatherTests
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import XCTest
@testable import Weather

class WeekViewViewModelTests: XCTestCase {
    
    var viewModel: WeekViewViewModel!
    
    override func setUp() {
        super.setUp()
        let data = loadStubFromBundle(withName: "darksky", ext: "json")
        let weatherData: WeatherData = try! JSONDecoder.decode(data: data)
        viewModel = WeekViewViewModel(weatherData: weatherData.dailyData)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    func testViewModelForIndex() {
        let weatherDayViewViewModel = viewModel.viewModel(for: 5)
        XCTAssertEqual(weatherDayViewViewModel.day, "Sunday")
        XCTAssertEqual(weatherDayViewViewModel.date, "December 25")
    }
}
