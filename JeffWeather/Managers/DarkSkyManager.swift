//
//  DarkSkyManager.swift
//  JeffWeather
//
//  Created by Jeff Glasse on 6/24/19.
//  Copyright © 2019 Jeff Glasse. All rights reserved.
//

import Foundation

class DarkSkyManager {
    private let APIKey = "7c6b20e30a993f19805cbe6100f1d552"
    private var BURL:String {
        return "https://api.darksky.net/forecast/"+APIKey
    }
    private let contentType = "application/json"
    private let userAgent = "com.glasseHouse.JeffWeather.ios"
    
    let networkManager = NetworkManager.sharedInstance

    init() {
        networkManager.baseURL = BURL
        networkManager.contentType = contentType
        networkManager.userAgent = userAgent
    }
    
    
    
    
    
}
