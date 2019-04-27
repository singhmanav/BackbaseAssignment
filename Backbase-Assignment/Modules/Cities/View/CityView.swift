//
//  CityView.swift
//  Backbase-Assignment
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//

import Foundation

protocol CityView: class {
    func configure(with cityTrie: Trie<City>,cityInfo: [City])
    func display(error: ModelError)
    func setActivityIndicator(hidden: Bool)
}
