//
//  CityListViewModel.swift
//  MyWeatherApp
//
//  Created by abramovanto on 13.05.2024.
//

import Foundation

final class CitySelectionViewModel: ObservableObject {
    @Published var cities: [CityItem] = [CityItem(cityName: "Москва")]
    @Published var userInput = ""
    
    func add(name: String) {
        let newCity = CityItem(cityName: name)
        cities.append(newCity)
    }
    
    func delete(index: IndexSet) {
        cities.remove(atOffsets: index)
    }
}
