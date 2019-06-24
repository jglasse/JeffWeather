//
//  DayModel.swift
//  JeffWeather
//
//  Created by Jeff Glasse on 6/23/19.
//  Copyright © 2019 Jeff Glasse. All rights reserved.
//

import Foundation
import UIKit

struct Day {
    var time: Date
    var icon: String
    var temperatureMax: Float
    var temperatureMin: Float
    
    
}

struct forecast {
    var forecast: [Day]
}
