//
//  NetworkManager.swift
//  JeffWeather
//
//  Created by Jeff Glasse on 6/23/19.
//  Copyright © 2019 Jeff Glasse. All rights reserved.
// Boilerplate Swift networking code for GET requests

import Foundation

class NetworkManager {
    var baseURL = ""
    var contentType = ""
    var userAgent = ""
    
    static var sharedInstance  =  NetworkManager()
    var singleNetworkSession = URLSession(configuration: .default)
    
    
    
    // MARK: - Generic Network functions
    private func genericAPIGETRequest<T: Codable>(path: String, returnType: T.Type, completionBlock: ((T?, Error?)->Void)?) {
        // create request and dataTask from path.
        let request = URLRequestGenerator(path: path)
        let task = singleNetworkSession.dataTask(with: request) { (data, response, responseError) in
            //Once datatask completed, check for errors, and handle them
            guard responseError == nil else {
                self.handleNetworkError(error: responseError, response: response)
                return
            }
            // otherwsise, process the returned data into the appropriate Type
            if let myData = data {
                self.logReceivedJSON(data: myData)
                let decoder = JSONDecoder()
                
                do {
                    let myResponse = try decoder.decode(T.self, from: myData)
                    devLog("PARSED DATA DUMP:")
                    devDump(myResponse)
                    if let happyEnding = completionBlock {
                        devLog("setup complete!")
                        happyEnding(myResponse, nil)
                    }
                } catch {
                    self.handleLocalError(error: error)
                    if let unhappyEnding = completionBlock {
                        print("setup decode failed!")
                        unhappyEnding(nil, error)
                    }
                    return
                }
            } else { // responseData is nil
                print("no readable data in response")
            }
        }
        task.resume() // this should really be called "start" as it's called to begin the dataTask.
    }
    
    
    private func URLRequestGenerator(path: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = path
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components")
        }
        var request = URLRequest(url: url)
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = contentType
        headers["User-Agent"] = userAgent
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"  // default  request method; overridden in calls which need post or put
        
        devLog("REQUEST DUMP:")
        devDump(request)
        return request
    }
    
    
    // 
    func logReceivedJSON(data: Data) {  // logging method for developers
        let jsonString = String(data: data, encoding: .utf8)
        devLog("JSON receieved: \(String(describing: jsonString))")
    }
    
    
    // MARK: - Error Handling
    private func handleLocalError(error: Error?) { // handles local errors, generally JSON decoding
        if let returnedError = error {
            devLog("APTMobileNetworkManager returned local error \(returnedError.localizedDescription)")
        } else {
            devLog("handleError called, but no error passed")
        }
    }
    
    private func handleNetworkError(error: Error?, response: URLResponse?) {// handles errors returned from URLResponse
        if let returnedError = error {
            devLog("APTMobileNetworkManager returned network error \(returnedError.localizedDescription)")
            if let myResponse = response as? HTTPURLResponse {
                devLog("Response code: \(myResponse.statusCode))")
                devLog("Response headers: \(myResponse.allHeaderFields))")
            }
        } else {
            devLog("handleNetworkError called, but no error passed")
        }
    }
    
}
