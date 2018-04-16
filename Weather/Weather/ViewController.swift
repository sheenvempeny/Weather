//
//  ViewController.swift
//  Weather
//
//  Created by sheen vempeny on 4/13/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import UIKit
import SDWebImage

extension String {
    
    func imageUrl() -> String{
        let returnStr = String(format: "%@%@.png", Settings.shared.imageUrl()!,self)
        return returnStr
    }
}

extension Date{
    
    func formattedDate() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblMax:UILabel!
    @IBOutlet weak var lblMin:UILabel!
    @IBOutlet weak var lblLocation:UILabel!
    @IBOutlet weak var imageView:UIImageView!
    
    private var weatherViewModel:WeatherViewModel!
    private var locationManager:LocationManager!
    private var weatherManager:WeatherManager!
    
    @IBAction func refresh(sender:AnyObject){
        self.updateWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager = LocationManager()
        self.weatherManager = WeatherManager()
        self.createViewModel()
        self.updateWeather()
    }
    
    func updateWeather(){
        if let location = self.locationManager.getLocInfo() {
            self.weatherManager.fetch(location: location) { (details:WeatherDetails?) in
                self.weatherViewModel.details = details
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController{
    
    private func createViewModel(){
        
        self.weatherViewModel = WeatherViewModel()
        self.weatherViewModel.imageView = self.imageView
        self.weatherViewModel.lblDate = self.lblDate
        self.weatherViewModel.lblLocation = self.lblLocation
        self.weatherViewModel.lblMax = self.lblMax
        self.weatherViewModel.lblMin = self.lblMin
    }
    
}

class WeatherViewModel {
    
    weak var lblDate:UILabel!
    weak var lblMax:UILabel!
    weak var lblMin:UILabel!
    weak var lblLocation:UILabel!
    weak var imageView:UIImageView!
    
    var details:WeatherDetails?{
        didSet{
            self.updateFields()
        }
    }
    
    private func updateFields(){
        
        if self.details == nil {
            self.lblDate.text = ""
            self.imageView.image = nil
            self.lblMin.text = ""
            self.lblMax.text = ""
            self.lblLocation.text = ""
        }
        else{
            
            self.lblMin.text = String(format: "min %0.f°C", self.details!.temp_min)
            self.lblMax.text = String(format: "max %0.f°C", self.details!.temp_max)
            self.lblLocation.text = String(format: "%@,%@", self.details!.location,self.details!.country)
            self.lblDate.text = "Today, " +  self.details!.date.formattedDate()
            self.imageView.sd_setImage(with: URL(string: self.details!.icon!.imageUrl()), completed: nil)
        }
    }
}
