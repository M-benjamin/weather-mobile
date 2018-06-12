//
//  City.swift
//  weather app
//
//  Created by Efrei Paris on 10/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

import Foundation


import Foundation
import CoreLocation
import MapKit
import AddressBook

struct City {
    var name: String
    var coordinates: CLLocationCoordinate2D
    var forecast: Forecast?
 
    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
    }
    
}
