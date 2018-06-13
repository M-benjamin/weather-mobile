//
//  HourlyCell.swift
//  weather app
//
//  Created by Efrei Paris on 12/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

import UIKit

class HourlyCell: UITableViewCell {
    @IBOutlet weak var imageHourly: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configureCell(forecastHour: ForecastHourly){
        humidityLabel.text = "\(Int(forecastHour.precipitationTemp * 100))%"
        tempLabel.text = "\(Int(forecastHour.Temp))°C"
        imageHourly.image = UIImage(named: forecastHour.weatherIcon)
        dayLabel.text = forecastHour.date
    }
}
