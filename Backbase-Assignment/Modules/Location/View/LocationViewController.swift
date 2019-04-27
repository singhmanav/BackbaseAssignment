//
//  MapViewController.swift
//  Backbase-Assignment
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//

import UIKit
import MapKit
class LocationViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    var city: City?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = city?.name ?? "Location"
        loadMap()
    }
    
    fileprivate func loadMap() {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: city?.coord.lat ?? 0, longitude: city?.coord.lon ?? 0)
        let viewRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000);
        let adjustedRegion = self.mapView.regionThatFits(viewRegion)
        mapView.setRegion(adjustedRegion, animated: true)
        mapView.addAnnotation(pin)
    }
}
