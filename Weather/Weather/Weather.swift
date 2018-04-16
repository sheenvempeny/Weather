//
//  Weather.swift
//  Weather
//
//  Created by sheen vempeny on 4/14/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import UIKit

fileprivate struct WeatherResponse: Decodable {
    
    struct weatherInfo: Decodable {
        var id:Int //Weather condition id
        var main:String //Group of weather parameters (Rain, Snow, Extreme etc.)
        var description:String //Weather condition within the group
        var icon:String //Weather icon id
    }
    
    struct Main: Decodable {
        var temp:Double //Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
        var pressure:Double? //Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
        var humidity:Double? //Humidity, %
        var temp_min:Double //Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
        var temp_max:Double //Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
        var sea_level:Double? //Atmospheric pressure on the sea level, hPa
        var grnd_level:Double? //Atmospheric pressure on the ground level, hPa
    }
    
    
    struct Sys:Decodable {
        var type:Int?
        var id:Int?
        var message:Double?
        var country:String
        var sunrise:Int64?
        var sunset:Int64?
    }
    
    var sys:Sys
    var cod:Int
    var name:String
    var dt: Int
    var main:Main
    var weather: [weatherInfo]
}

struct WeatherDetails : Decodable {
    
    var temp_max: Double
    var temp_min: Double
    var date: Date
    var location:String
    var icon:String?
    var country:String
    
    init(from decoder: Decoder) throws {
        let rawResponse = try WeatherResponse(from: decoder)
        
        temp_max = rawResponse.main.temp_max
        temp_min = rawResponse.main.temp_min
        date = Date(timeIntervalSince1970: TimeInterval(rawResponse.dt))
        location = rawResponse.name
        icon = rawResponse.weather.first?.icon
        country = rawResponse.sys.country
    }
}

