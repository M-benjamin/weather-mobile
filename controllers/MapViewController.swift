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

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var cities: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        
        
        
        for city in CitiesData.list {
            let pin = MKPointAnnotation()
            pin.coordinate = city.coordinates
            pin.title = city.name
            mapView.addAnnotation(pin)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailId") as! DetailsWeatherViewController
        
        detailsViewController.coordinate = view.annotation?.coordinate
        detailsViewController.name = view.annotation?.title!
        
        self.navigationController?.pushViewController(detailsViewController, animated: true)
        
    }

        
}



