//
//  CurrentWeather.swift
//  weather app
//
//  Created by Efrei Paris on 12/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CurrentWeather{
    var date: String
    var weatherType: String
    var weatherIcon: String
    var currentTemp: Double
    var dailySummury: String
    var hourlySummury: String
    var windSpeed: Double
    var pressure: Double
    var humidity: Double
    var UV: Double
    
    init(json: JSON) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        let dateD = "Today, \(currentDate)"
        
        self.date = dateD
        self.dailySummury = json["daily"]["summary"].stringValue
        self.hourlySummury = json["hourly"]["summary"].stringValue
        self.weatherType = json["currently"]["summary"].stringValue
        self.weatherIcon = json["currently"]["icon"].stringValue
        self.currentTemp = json["currently"]["temperature"].doubleValue
        self.windSpeed = json["currently"]["windSpeed"].doubleValue
        self.pressure = json["currently"]["pressure"].doubleValue
        self.humidity = json["currently"]["humidity"].doubleValue
        self.UV = json["currently"]["uvIndex"].doubleValue
    }
    
}
