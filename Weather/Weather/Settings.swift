//
//  Settings.swift
//  Weather
//
//  Created by sheen vempeny on 4/14/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import UIKit

class Settings {
    
    private let weatherAppKey = "WeatherKey"
    private let weatherAppAPIKey = "weatherAPI"
    private let imageUrlKey = "ImageUrl"
    
    static let shared = Settings()
    
    private func bundleInfo() -> NSDictionary?{
        
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        return myDict
    }
    func imageUrl() -> String?{
        var answer:String?
        if let dict = self.bundleInfo() {
            answer = dict.object(forKey: imageUrlKey) as? String
        }
        return answer
    }
    
    func weatherKey() -> String?{
        var answer:String?
        if let dict = self.bundleInfo() {
            answer = dict.object(forKey: weatherAppKey) as? String
        }
        return answer
    }
    func weatherAPI() -> String?{
        var answer:String?
        if let dict = self.bundleInfo() {
            answer = dict.object(forKey: weatherAppAPIKey) as? String
        }
        return answer
    }
    
}
