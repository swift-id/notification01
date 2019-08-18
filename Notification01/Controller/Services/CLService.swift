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
    var shouldSetRegion = true
    
    func authorize() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocation() {
        shouldSetRegion = true
        
        locationManager.startUpdatingLocation()
    }
}

extension CLService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first, shouldSetRegion else { return }
        
        shouldSetRegion = false
        
        let region = CLCircularRegion(center: currentLocation.coordinate,
                                      radius: 20,
                                      identifier: "startingPosition")
        
        locationManager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        NotificationCenter.default.post(name: NSNotification.Name("notification.enteredRegion"), object: nil)
    }
}
