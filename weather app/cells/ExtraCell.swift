//
//  ExtraCell.swift
//  weather app
//
//  Created by Efrei Paris on 12/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

import UIKit

class ExtraCell: UITableViewCell {
    @IBOutlet weak var humidityText: UILabel!
    @IBOutlet weak var humidityValue: UILabel!
    @IBOutlet weak var windText: UILabel!
    @IBOutlet weak var windValue: UILabel!
    @IBOutlet weak var pressureTitle: UILabel!
    @IBOutlet weak var pressureValue: UILabel!
    @IBOutlet weak var uvText: UILabel!
    @IBOutlet weak var uvValue: UILabel!
    
    func configureCell(currentTemp: CurrentWeather){
        humidityText.text = "Humidity"
        humidityValue.text = "\(Int(currentTemp.humidity * 100)) %"
        windText.text = "Wind Speed"
        windValue.text = "\(Int(currentTemp.windSpeed)) km/h"
        pressureTitle.text = "Pressure"
        pressureValue.text = "\(Int(currentTemp.pressure))hPa"
        uvText.text = "UV Index"
        uvValue.text = "\(Int(currentTemp.UV))"
    }
}
