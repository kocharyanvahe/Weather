//
//  XCTestCase.swift
//  WeatherTests
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import XCTest

extension XCTestCase {
    func loadStubFromBundle(withName name: String, ext: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: ext)
        return try! Data(contentsOf: url!)
    }
}
