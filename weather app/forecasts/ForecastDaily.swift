//
//  ForecastDaily.swift
//  weather app
//
//  Created by Efrei Paris on 11/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForecastDaily {
    var dateF: String
    var weatherIcon: String
    var highTemp: Double
    var lowTemp: Double
   
    init(weatherDict: JSON) {
            self.lowTemp = weatherDict["temperatureMin"].doubleValue
            self.highTemp = weatherDict["temperatureMax"].doubleValue
            self.weatherIcon = weatherDict["icon"].stringValue

            let unixConvertedDate = Date(timeIntervalSince1970: weatherDict["time"].doubleValue)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            
            self.dateF = unixConvertedDate.dayOfTheWeek().capitalized
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

