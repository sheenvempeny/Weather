//
//  LocationManager.swift
//  Weather
//
//  Created by sheen vempeny on 4/14/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import UIKit
import MapKit

class LocationManager {
    
    private var locManager:CLLocationManager!
    
    
    init() {
        self.locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
    }
    
    func getLocInfo() -> CLLocation?{
        var currentLocation: CLLocation?
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            return currentLocation
        }
        return nil
    }
    
    
    
    
}
