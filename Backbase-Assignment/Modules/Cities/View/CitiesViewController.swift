//
//  ViewController.swift
//  Backbase-Assignment
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//

import UIKit
import MapKit
class CitiesViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    var presenter: CityPresenter? {
        didSet {
            presenter?.loadCityInfo()
        }
    }
    var selectedCity:City!
    var cities = [City]()
    var initialCities = [City]()
    var citiesTrie:Trie<City>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = CityPresenterImpl(view: self, model: CityModelImpl())
        self.presenter = presenter
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadMap(city:City) {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: city.coord.lat , longitude: city.coord.lon )
        let viewRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000);
        let adjustedRegion = self.mapView.regionThatFits(viewRegion)
        self.mapView.setRegion(adjustedRegion, animated: true)
        self.mapView.addAnnotation(pin)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstant.StoryBoardID.LocationViewController.rawValue {
            let locationController = segue.destination as? LocationViewController
            locationController?.city = selectedCity
        }
    }
    
}



