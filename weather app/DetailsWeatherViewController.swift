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

class DetailsWeatherViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var name: String?
    var coordinate: CLLocationCoordinate2D?
    var currentWeather: CurrentWeather!
     var selectedCity: City?
    override func viewDidLoad() {
        if (selectedCity != nil){
            coordinate = selectedCity?.coordinates
            name = selectedCity?.name
        }
        super.viewDidLoad()
         self.navigationItem.title = name
        tableView.delegate = self
        tableView.dataSource = self
        requestDetails()
    }
    
    func requestDetails() {
        guard let lat = coordinate?.latitude , let long = coordinate?.longitude else {return}
        Alamofire.request("\(CURRENT_WEATHER_URL)\(lat),\(long)?si").responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .none
                let currentDate = dateFormatter.string(from: Date())
                let myDate = "Today, \(currentDate)"
                
                self.dateLabel.text = myDate
                self.temperatureLabel.text = "\(json["currently"]["temperature"].doubleValue)°C"
                self.locationLabel.text = self.name
                self.currentWeatherTypeLabel.text = json["currently"]["summary"].stringValue
                self.currentWeatherImage.image = UIImage(named: json["currently"]["icon"].stringValue)
                
                self.tableView.reloadData()
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyCell", for: indexPath) as! HourlyCell

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as! DailyCell

            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "extraCell", for: indexPath) as! ExtraCell

            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
        case 0:
            return "hourly"
        case 1:
            return "daily"
        case 2:
            return "extra"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 20)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func updateUi() {
//        dateLabel.text = currentWeather?.date
//        temperatureLabel.text = "\(currentWeather?.currentTemp)"
//        locationLabel.text = name
//        currentWeatherTypeLabel.text = currentWeather?.weatherType
//        currentWeatherImage.image = UIImage(named: (currentWeather?.weatherType)!)
    }
}
