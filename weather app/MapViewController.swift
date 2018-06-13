//
//  MapViewController.swift
//  weather app
//
//  Created by Efrei Paris on 10/06/2018.
//  Copyright © 2018 Efrei Paris. All rights reserved.
//

import UIKit
import MapKit
import AddressBook

class MapViewController: UIViewController, MKMapViewDelegate,UITableViewDataSource {
    var citiess : [City] = CitiesData.list
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideBarConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mapView: MKMapView!
   var rightBarHidden = true
    @IBAction func rightBtnPress(_ sender: UIBarButtonItem) {
        if rightBarHidden{
            sideBarConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
           
        }else{
            sideBarConstraint.constant = 200
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        
        }
              rightBarHidden = !rightBarHidden

    }
    var cities: City?
    
    override func viewDidLoad() {

        super.viewDidLoad()
         tableView.dataSource = self
         sideBarConstraint.constant = 200
        mapView.delegate = self

        for city in CitiesData.list {
            let pin = MKPointAnnotation()
            pin.coordinate = city.coordinates
            pin.title = city.name
            mapView.addAnnotation(pin)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiess.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.configure(city: citiess[indexPath.row])
        
        return cell
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailId") as! DetailsWeatherViewController
        detailsViewController.coordinate = view.annotation?.coordinate
        detailsViewController.name = view.annotation?.title!
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegueCell" {
            if let vc = segue.destination as? DetailsWeatherViewController, let index = tableView.indexPathForSelectedRow?.row {
                sideBarConstraint.constant = 200
                vc.selectedCity = citiess[index]
            }
        }
    }
}



