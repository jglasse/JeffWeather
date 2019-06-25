//
//  DayModel.swift
//  JeffWeather
//
//  Created by Jeff Glasse on 6/23/19.
//  Copyright © 2019 Jeff Glasse. All rights reserved.
//

import Foundation
import UIKit


struct DarkSkyResponse:Codable {
    var daily: Daily
}

struct Daily:Codable {
    var data: [Day]
}

struct Day:Codable {
    var time: Double
    var summary: String
    var icon: String
    var temperatureHigh: Float
    var temperatureLow: Float
    var actualDate: Date {
        return Date(timeIntervalSince1970: time)
    }
}

