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

    var _date: String!
    var weatherType: String
    var currentTemp: Double

    init(json: JSON) {
        self.weatherType = ""
        self.currentTemp = 0
    }
    
    var date: String! {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        
        self._date = "Today, \(currentDate)"
        return _date
    }
    
//    func update(json: JSON) {
//
//        self.weatherType = json["currently"]["summary"].stringValue
//        self.currentTemp = json["currently"]["temperature"].doubleValue
//    }
    
}
