//
//  Backbase_AssignmentTests.swift
//  Backbase-AssignmentTests
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//

import XCTest
@testable import Backbase_Assignment

class Backbase_AssignmentTests: XCTestCase {
    var trieData = Trie<City>()
    var aboutViewController : AboutViewController!
    var citiesViewController : CitiesViewController!
    var locationViewController: LocationViewController!
    override func setUp() {
        super.setUp()
        guard
            let path = Bundle.main.path(forResource: "MockCity", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            var decoded = try? JSONDecoder().decode([City].self, from: data)
            else { return }
        decoded.sort()
        decoded.forEach { city in
            trieData.insert(word: city.name, data: city)
            
        }
        
        aboutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AppConstant.StoryBoardID.AboutViewController.rawValue) as? AboutViewController
        let presenter = Presenter(view: aboutViewController, model: Model(), city: decoded.first!)
        aboutViewController?.presenter = presenter

        citiesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitiesViewController") as? CitiesViewController
        
        locationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        trieData = Trie<City>()
        aboutViewController = nil
        citiesViewController = nil
        locationViewController = nil
        super.tearDown()
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            guard
                let path = Bundle.main.path(forResource: "MockCity", ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
                var decoded = try? JSONDecoder().decode([City].self, from: data)
                else { return }
            decoded.sort()
            decoded.forEach { city in
                trieData.insert(word: city.name, data: city)
                
            }
            // Put the code you want to measure the time of here.
        }
    }
    func testSearch(){
        XCTAssert(trieData.words.count == 10, "Error in loading mock json")
        var cities = trieData.findWordsWithPrefix(prefix: "K")
        
        XCTAssert(cities.count == 1, "Error in finding city")
        
        cities = trieData.findWordsWithPrefix(prefix: "Kathmandu")
        if let cityName = cities.first?.name{
            XCTAssert(cityName == "Kathmandu", "Error in finding city")
        }
        cities = trieData.findWordsWithPrefix(prefix: "New")
        
        XCTAssert(cities.count == 0, "Error in finding city")
    }
    
    func testAboutVC(){
        XCTAssertNotNil(aboutViewController, "Error in loading View Controller")
        aboutViewController?.viewDidLoad()
        let numberOfRows = aboutViewController?.tableView.numberOfRows(inSection: 0)
        XCTAssert(numberOfRows == 8, "Error in loading Table View")
        let cell = aboutViewController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell, "Error in loading cell")
    }
    
    func testAboutModel(){
        let model = Model()
        guard let presenter = aboutViewController.presenter else{
            XCTAssert(false, "Error in loading presenter")
            return
        }
        model.loadAboutInfo(with: presenter)
    }
    
    func testAboutPresenter(){
        guard let presenter = aboutViewController.presenter else{
            XCTAssert(false, "Error in loading presenter")
            return
        }
        presenter.loadAboutInfo()
        presenter.aboutInfoDidFailLoading(error: .failedLoading)
    }
    
    func testCitiesVC(){
        let _ = citiesViewController.view
        let cities = trieData.findWordsWithPrefix(prefix: "Kathmandu")
        guard let city = cities.first else {
            XCTAssert(false, "Error in loading City Data")
            return
        }
        citiesViewController.loadMap(city: city)
        citiesViewController.display(error: ModelError.failedLoading)
    }
    
    func testLocationVC(){
        let cities = trieData.findWordsWithPrefix(prefix: "Kathmandu")
        let _ = locationViewController.view
        guard let city = cities.first else {
            XCTAssert(false, "Error in loading City Data")
            return
        }
        locationViewController.city = city
        locationViewController.viewDidLoad()
    }

}
