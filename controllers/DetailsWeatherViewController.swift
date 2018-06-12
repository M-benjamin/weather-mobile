//
//  DetailsWeatherViewController.swift
//  weather app
//
//  Created by Efrei Paris on 11/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class DetailsWeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var name: String?
    var coordinate: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = name
        fetchData()
    }

    func fetchData() {
        if let lat = coordinate?.latitude , let long = coordinate?.longitude {
            Alamofire.request("https://api.darksky.net/forecast/b8559c6c8b247d844069369a19a9d7b8/\(lat),\(long)").responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    
//                    self.model?.updateCocktail(json: json["drinks"].arrayValue.first!)
//                    self.tableView.reloadData()
                    print("JSON: \(json)") // serialized json response
                }
                
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    inRow
    
}
