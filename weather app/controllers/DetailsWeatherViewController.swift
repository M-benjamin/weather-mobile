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
    var currentWeather: CurrentWeather?
    var forecastsDay = [ForecastDaily]()
    var forecastsHours = [ForecastHourly]()
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
        
        self.downloadForecastData ()
    }
    
    
    func downloadForecastData () {
       
        guard let lat = coordinate?.latitude, let long = coordinate?.longitude else {return}
        Alamofire.request("https://api.darksky.net/forecast/b8559c6c8b247d844069369a19a9d7b8/\(lat),\(long)?si").responseJSON { response in
            
            guard response.result.error == nil else {
                print("error calling GET on Dark Sky API")
                print(response.result.error!)
                return
            }
            
            guard response.result.value != nil else {
                print("didn't get object as JSON from API")
                print("Error: \(String(describing: response.result.error))")
                return
            }
            
            if let data = response.result.value {
                let json = JSON(data)
                self.currentWeather = CurrentWeather(json: json)
                
                // > Get Daily data
                if let listDay = json["daily"]["data"].array  {
                    for obj in listDay {
                        let forecast = ForecastDaily(weatherDict: obj)
                        self.forecastsDay.append(forecast)
                    }
                    self.forecastsDay.remove(at: 0)
                }
                
                // > Get hourly data
                if let listHour = json["hourly"]["data"].array  {
                    
                    for obj in listHour {
                        let forecast = ForecastHourly(weatherDict: obj)
                        self.forecastsHours.append(forecast)
                    }
//                    self.forecastsDay.remove(at: 0)
                }
                
                self.updateMainUI()
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
            return forecastsHours.count
        case 1:
            return forecastsDay.count
        case 2:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyCell", for: indexPath) as? HourlyCell {
                let forecast = forecastsHours[indexPath.row]
                cell.configureCell(forecastHour: forecast)
                return cell
            } else {
                return HourlyCell()
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as? DailyCell {
                
                let forecast = forecastsDay[indexPath.row]
                cell.configureCell(forecastDay: forecast)
                return cell
            } else {
                return DailyCell()
            }
            
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "extraCell", for: indexPath) as? ExtraCell {
//                let current = currentWeather?.;[indexPath.row]
                if let currentWeather = currentWeather {
                    cell.configureCell(currentTemp: currentWeather)
                }
                return cell
            } else {
                return DailyCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
        case 0:
            return currentWeather?.hourlySummury
        case 1:
            return currentWeather?.dailySummury
        case 2:
            return "Extra informations"
        default:
            return nil
        }
    
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        
        let headerLabel = UILabel(frame: CGRect(x: 5, y: 10, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 10)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func updateMainUI() {
        if let currentWeather = currentWeather {
            dateLabel.text = currentWeather.date
            temperatureLabel.text = "\(Int(currentWeather.currentTemp))°C"
            locationLabel.text = name
            currentWeatherTypeLabel.text = currentWeather.weatherType
            currentWeatherImage.image = UIImage(named: currentWeather.weatherIcon)
        }
        
    }
}
