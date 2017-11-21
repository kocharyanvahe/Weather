//
//  Configuration.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import Foundation

struct Defaults {
    static let Latitude: Double = 51.400592
    static let Longitude: Double = 4.760970
}

struct API {
    static let APIKey = "ff1544318fb93a407ff367d7939e5c40"
    static let BaseURL = URL(string: "https://api.darksky.net/forecast/")!
    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
    }
}
