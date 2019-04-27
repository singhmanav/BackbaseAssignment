//
//  CitiesViewController+Extensions.swift
//  Backbase-Assignment
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//

import UIKit

extension CitiesViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath)
        cell.textLabel?.text = "\(cities[indexPath.row].name) , \(cities[indexPath.row].country)"
        cell.detailTextLabel?.text = "\(cities[indexPath.row].coord.lat), \(cities[indexPath.row].coord.lon)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let aboutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AppConstant.StoryBoardID.AboutViewController.rawValue) as? AboutViewController else { return }
        let presenter = Presenter(view: aboutViewController, model: Model(),city: cities[indexPath.row])
        aboutViewController.presenter = presenter
        self.navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UIDevice.current.orientation.isLandscape {
            self.searchBar.resignFirstResponder()
            self.loadMap(city: cities[indexPath.row])
        }else{
            self.searchBar.resignFirstResponder()
            self.selectedCity = cities[indexPath.row]
            performSegue(withIdentifier: AppConstant.StoryBoardID.LocationViewController.rawValue, sender: nil)
        }
    }
    
}


extension CitiesViewController: CityView {
    func configure(with cityTrie: Trie<City>, cityInfo: [City]) {
        self.citiesTrie = cityTrie
        self.cities = cityInfo
        self.initialCities = cityInfo
        self.tableView.reloadData()
    }
    
    func display(error: ModelError) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setActivityIndicator(hidden: Bool) {
        if hidden {
            self.activityIndicator.stopAnimating()
        } else {
            self.activityIndicator.startAnimating()
        }
    }
}

extension CitiesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            cities = self.initialCities
        }else{
            cities = self.citiesTrie.findWordsWithPrefix(prefix: searchText).sorted(by: <)
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cities = self.initialCities
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
