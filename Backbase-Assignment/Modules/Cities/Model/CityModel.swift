//
//  CityModel.swift
//  Backbase-Assignment
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//

import Foundation

protocol CityModel {
    func loadCityInfo(with presenter: CityPresenter)
}

// MARK: - Model class implementation

class CityModelImpl: NSObject, CityModel {
    public override init() {
        super.init()
    }
    
    func loadCityInfo(with presenter: CityPresenter) {
        let trie = Trie<City>()
        guard
            let path = Bundle.main.path(forResource: "cities", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            var decoded = try? JSONDecoder().decode([City].self, from: data)
            else {
                presenter.cityInfoDidFailLoading(error: ModelError.failedLoading)
                return
        }
        decoded.sort()
        decoded.forEach { trie.insert(word: $0.name, data: $0) }
        DispatchQueue.main.async {
            presenter.cityInfoDidLoad(with:trie, cityInfo: decoded)
        }
    }
}
