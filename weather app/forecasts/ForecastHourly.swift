//
//  ForecastHourly.swift
//  weather app
//
//  Created by Efrei Paris on 13/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForecastHourly {
    var date: String
    var weatherIcon: String
    var Temp: Double
    var precipitationTemp: Double
    
    init(weatherDict: JSON) {
        self.precipitationTemp = weatherDict["humidity"].doubleValue
        self.Temp = weatherDict["temperature"].doubleValue
        self.weatherIcon = weatherDict["icon"].stringValue
        
        let unixConvertedDate = Date(timeIntervalSince1970: weatherDict["time"].doubleValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeStyle = .none
        
        self.date = unixConvertedDate.hourOfTheDay()
        
        print(" date of day ---------- >>>>>> \(self.date)")
    }
}

extension Date {
    func hourOfTheDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self)
    }
}

