//
//  DailyCell.swift
//  weather app
//
//  Created by Efrei Paris on 12/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

import UIKit

class DailyCell: UITableViewCell {
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    
    func configureCell(forecastDay: ForecastDaily){
        lowTempLabel.text = "\(Int(forecastDay.lowTemp))°C"
        highTempLabel.text = "\(Int(forecastDay.highTemp))°C"
        weatherIcon.image = UIImage(named: forecastDay.weatherIcon)
        dayLabel.text = forecastDay.dateF
    }
}
