//
//  WeatherManager.swift
//  Weather
//
//  Created by sheen vempeny on 4/14/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

typealias WeatherDetailsHandler = (WeatherDetails?) -> Void

class WeatherManager: NSObject {
    
    func fetch(location:CLLocation,handler:@escaping WeatherDetailsHandler){
        
        let api = Settings.shared.weatherAPI()
        let key = Settings.shared.weatherKey()
        
        guard api != nil && key != nil else{
            return
        }
        
        //Construct parameters
        let parameters:Parameters = [
            "lat" : location.coordinate.latitude,
            "lon" : location.coordinate.longitude,
            "units":"metric",
            "appid" : key!]
        
        Alamofire.request(api!, method: .get, parameters: parameters, encoding: URLEncoding.default).response { response in
            
            do {
                
                if response.response?.statusCode == 200 {
                    
                    let decoder = JSONDecoder()
                    let details = try decoder.decode(WeatherDetails.self, from: response.data!)
                    handler(details)
                }
                else{
                    handler(nil)
                }
                
            } catch _ {
                handler(nil)
            }
        }
    }
}
