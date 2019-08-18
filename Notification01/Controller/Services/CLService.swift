//
//  CLService.swift
//  Notification01
//
//  Created by R. Kukuh on 19/08/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation
import CoreLocation

class CLService: NSObject {
    
    private override init() {}
    
    static let shared = CLService()
    
    let locationManager = CLLocationManager()
    
    func authorize() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension CLService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location detected")
    }
}
