//
//  CityListViewModel.swift
//  MyWeatherApp
//
//  Created by abramovanto on 13.05.2024.
//

import Foundation
import SwiftUI

final class CitySelectionViewModel: ObservableObject {
    @Published var cities: [CityItem] = []
    @Published var userInput = ""
    @Published var backgroundColor = Color(UIColor(named: "BaseViewColor")!)

    func add(name: String) {
        let newCity = CityItem(cityName: name)
        cities.append(newCity)
        saveData()
    }
    
    func delete(index: IndexSet) {
        cities.remove(atOffsets: index)
    }

    func saveData() {
        let citiesData = try! PropertyListEncoder().encode(cities)
        UserDefaults.standard.set(citiesData, forKey: "cityName")
    }

    init() {
        let fetchedData = UserDefaults.standard.data(forKey: "cityName")!
        let fetchedCities = try! PropertyListDecoder().decode([CityItem].self, from: fetchedData)
        cities = fetchedCities
    }
}
