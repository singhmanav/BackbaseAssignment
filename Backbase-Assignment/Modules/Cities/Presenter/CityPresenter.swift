//
//  CityPresenter.swift
//  Backbase-Assignment
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//

import Foundation

protocol CityPresenter {
    func loadCityInfo()
    func cityInfoDidLoad(with cityTrie: Trie<City>, cityInfo :[City])
    func cityInfoDidFailLoading(error: ModelError)
}

// MARK: - Presenter implementation

class CityPresenterImpl: CityPresenter {
    
    private weak var view: CityView?
    private let model: CityModel
    
    public init(view: CityView?, model: CityModel) {
        self.view = view
        self.model = model
    }
    
    public func loadCityInfo() {
        self.view?.setActivityIndicator(hidden: false)
        self.model.loadCityInfo(with: self)
    }
    
    public func cityInfoDidLoad(with cityTrie: Trie<City>, cityInfo :[City]) {
        self.view?.setActivityIndicator(hidden: true)
        self.view?.configure(with: cityTrie, cityInfo: cityInfo)
    }
    
    public func cityInfoDidFailLoading(error: ModelError) {
        self.view?.setActivityIndicator(hidden: true)
        self.view?.display(error: error)
    }
}
