//
//  ViewController.swift
//  SunsetSunrise
//
//  Created by PHILIP SHEN on 1/4/18.
//  Copyright © 2018 PHILIP SHEN. All rights reserved.
//

import UIKit
import CoreLocation
import Solar

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!

    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let coords = location.coordinate
            
            let solar = Solar(coordinate: coords)
            let sunrise = solar?.sunrise
            let sunset = solar?.sunset
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            sunriseLabel.text = formatter.string(from: sunrise!)
            sunsetLabel.text = formatter.string(from: sunset!)
            
            print("Location: \(location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user's location: \(error.localizedDescription)")
    }

}

