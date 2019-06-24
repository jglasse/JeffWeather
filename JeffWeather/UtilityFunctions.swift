//
//  UtilityFunctions.swift
//  JeffWeather
//
//  Created by Jeff Glasse on 6/23/19.
//  Copyright © 2019 Jeff Glasse. All rights reserved.
//

import Foundation

// global functions for dev cycle

func devLog(_ item: Any) {
    #if DEBUG
    print(item)
    #endif
}

func devDump(_ item: Any) {
    #if DEBUG
    dump(item)
    #endif
}
