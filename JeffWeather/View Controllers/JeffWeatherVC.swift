//
//  ViewController.swift
//  JeffWeather
//
//  Created by Jeff Glasse on 6/20/19.
//  Copyright © 2019 Jeff Glasse. All rights reserved.
//

import UIKit
import CoreLocation


class JeffWeatherVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate {
    var currentLocation: CLLocation?
    let locationManager = CLLocationManager()
    var foreCastModel = [Day]()
    let sampleModel = [Day(time: Date(), icon: "clear-day", temperatureMax: 80, temperatureMin: 30),Day(time: Date(), icon: "clear-night", temperatureMax: 80, temperatureMin: 30),Day(time: Date(), icon: "fog", temperatureMax: 80, temperatureMin: 30),Day(time: Date(), icon: "cloudy", temperatureMax: 80, temperatureMin: 30),Day(time: Date(), icon: "partly-cloudy-day", temperatureMax: 80, temperatureMin: 30),Day(time: Date(), icon: "partly-cloudy-day", temperatureMax: 80, temperatureMin: 30),Day(time: Date(), icon: "partly-cloudy-night", temperatureMax: 80, temperatureMin: 30),Day(time: Date(), icon: "sleet", temperatureMax: 80, temperatureMin: 30),Day(time: Date(), icon: "snow", temperatureMax: 80, temperatureMin: 30),Day(time: Date(), icon: "wind", temperatureMax: 80, temperatureMin: 30)]
    let dayFormatter = DateFormatter()
    let darkSkyManager = DarkSkyManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayFormatter.dateFormat = "EE"
        locationManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions & IBOutlets

    @IBAction func forecast(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    

    
}




// MARK: - CoreLocation Methods

extension JeffWeatherVC {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locationManager.location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        devLog("location manager failure")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("locationManager didChangeAuthorization")
        if status == .authorizedWhenInUse
        {
            locationManager.requestLocation()
            currentLocation = locationManager.location
            devLog(currentLocation)
        }
        else
        {
            currentLocation = nil // not really necessary, but here for clarity
        }
    }
    
}

// MARK: -


// MARK: - UICOllectiomView Methods
extension JeffWeatherVC {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleModel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
     //   set labels and image here
        cell.dayField.text = dayFormatter.string(from: sampleModel[indexPath.item].time)
        if let iconImage = UIImage(named: sampleModel[indexPath.item].icon)
        {
            cell.imageView.image = iconImage
        }
        else
        {
            cell.imageView.image = UIImage(named: "undefined")
        }
        
        cell.highField.text = String(sampleModel[indexPath.item].temperatureMax)
        cell.lowField.text = String(sampleModel[indexPath.item].temperatureMin)
        return cell
    }
    
    
}

