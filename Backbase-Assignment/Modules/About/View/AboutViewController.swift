//
//  File.swift
//  Backbase-Assignment
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//

import UIKit

class AboutViewController : UITableViewController {
    typealias AboutInfoField = (name: String, keyPath: KeyPath<AboutInfoData, String>)
    
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    let fields: [AboutInfoField] = [
        (name: "Name", keyPath: \AboutInfoData.companyName),
        (name: "Address", keyPath: \AboutInfoData.companyAddress),
        (name: "Postal Code", keyPath: \AboutInfoData.postalCode),
        (name: "City", keyPath: \AboutInfoData.city),
        (name: "Details", keyPath: \AboutInfoData.details),
        (name: "Country", keyPath: \AboutInfoData.country),
        (name: "Latitude", keyPath: \AboutInfoData.latitude),
        (name: "Longitude", keyPath: \AboutInfoData.longitude)
        ]
    
    var presenter: AboutPresenter? {
        didSet {
            presenter?.loadAboutInfo()
        }
    }
    var aboutInfo: AboutInfoData?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        
        self.navigationItem.titleView = self.activityIndicatorView
        self.activityIndicatorView.hidesWhenStopped = true
    }
    
    // MARK: - UITableViewDataSource methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let aboutInfo = self.aboutInfo else { return UITableViewCell() }
        
        let field = self.fields[indexPath.row]
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "AboutInfoCell") {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .value2, reuseIdentifier: "AboutInfoCell")
            cell.selectionStyle = .none
        }
        cell.detailTextLabel?.numberOfLines = 2
        cell.textLabel?.text = field.name
        cell.detailTextLabel?.text = aboutInfo[keyPath: field.keyPath]
        
        return cell
    }
}

// MARK: - AboutView protocol methods

extension AboutViewController: AboutView {
    func configure(with aboutInfo: AboutInfoData) {
        self.aboutInfo = aboutInfo
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
            self.activityIndicatorView.stopAnimating()
        } else {
            self.activityIndicatorView.startAnimating()
        }
    }
}
