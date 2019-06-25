//
//  DarkSkyManager.swift
//  JeffWeather
//
//  Created by Jeff Glasse on 6/24/19.
//  Copyright © 2019 Jeff Glasse. All rights reserved.
//

import Foundation

class DarkSkyManager {
    static var sharedInstance  =  NetworkManager()
    var model = [Day]()
    private let networkManager = NetworkManager.sharedInstance

    
    func getForecast(lat: String, long: String, UIcompletion: @escaping ()->Void) {
        let fullPath = "\(lat),\(long)"
        networkManager.genericAPIGETRequest(path: fullPath, returnType: DarkSkyResponse.self, completionBlock: {(response, error) in
            self.model = response?.daily.data ?? [Day]()
            UIcompletion()
        })
    }
    
    func getForeCastCompletion(response: DarkSkyResponse?, err: Error?) {
        self.model = response?.daily.data ?? [Day]()
        print("getForeCastCompletion COMPLETED")
        print("self.model =  \(self.model)")
        print("self.model.count =  \(self.model.count)")
    
    }
    
}
