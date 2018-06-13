//
//  CityTableViewCell.swift
//  weather app
//
//  Created by madjid on 13/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

//

import UIKit
import SDWebImage

class CityTableViewCell: UITableViewCell {
 
    
    @IBOutlet weak var cityName: UILabel!
    func configure(city: City) {
        cityName.text = city.name
    }
}
