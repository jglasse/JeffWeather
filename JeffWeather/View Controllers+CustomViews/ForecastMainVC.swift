//
//  ForecastMainVC.swift
//  JeffWeather
//
//  Created by Jeff Glasse on 6/20/19.
//  Copyright © 2019 Jeff Glasse. All rights reserved.
//

import UIKit
import CoreLocation


class ForecastMainVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate {
    var currentLocation: CLLocation?
    let locationManager = CLLocationManager()
   // let sampleModel = [Day(time: Date(), icon: "blah", temperatureMax: 50, temperatureMin: 20, summary: "<#T##String#>")]
    let dayFormatter = DateFormatter()
    let darkSkyManager = DarkSkyManager()
    var currentLat = ""
    var currentLong = ""
    
    
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

extension ForecastMainVC {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locationManager.location
        currentLat = "\(currentLocation?.coordinate.latitude ?? 0)"
        currentLong = "\(currentLocation?.coordinate.longitude ?? 0)"
        darkSkyManager.getForecast(lat: currentLat, long: currentLong, UIcompletion: self.forecastCollectionView.reloadData)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        devLog("location manager failure")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse
        {
            locationManager.requestLocation()
            currentLocation = locationManager.location
            devLog(currentLocation as Any)
            DispatchQueue.main.async {
            self.forecastCollectionView.reloadData()
            }
            
        }
        else
        {
            devLog("didChangeAuthorization, but access has not been granted")
        }
    }
    
}

// MARK: -


// MARK: - UICOllectiomView Methods
extension ForecastMainVC {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let summaryVC = (storyboard?.instantiateViewController(withIdentifier: "summaryView")) as! SummaryVC
        summaryVC.summary = darkSkyManager.model[indexPath.item].summary
        self.navigationController?.pushViewController(summaryVC, animated: true)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return darkSkyManager.model.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
     //   set labels and image here
        cell.dayField.text = dayFormatter.string(from: darkSkyManager.model[indexPath.item].actualDate)
        if let iconImage = UIImage(named: darkSkyManager.model[indexPath.item].icon)
        {
            cell.imageView.image = iconImage
        }
        else
        {
            cell.imageView.image = UIImage(named: "undefined")
        }
        cell.highField.text = String(format: "%.0f", darkSkyManager.model[indexPath.item].temperatureHigh)
        cell.lowField.text = String(format: "%.0f", darkSkyManager.model[indexPath.item].temperatureLow)
        return cell
    }
    
    
}

