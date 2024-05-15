//
//  CityListViewModel.swift
//  MyWeatherApp
//
//  Created by abramovanto on 13.05.2024.
//

import Foundation

class CityListViewModel: ObservableObject {
    @Published var cities: [CityItem] = [CityItem(cityName: "Москва")]
    
    func add(name: String) {
        let newCity = CityItem(cityName: name)
            cities.append(newCity)
    }
    
    func delete(index: IndexSet) {
        cities.remove(atOffsets: index)
    }
}


