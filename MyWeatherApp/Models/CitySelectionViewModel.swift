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
    @Published var backgroundColor = Color.init(red: 47/255, green: 79/255, blue: 79/255)

    func add(name: String) {
        let newCity = CityItem(cityName: name)
        cities.append(newCity)
    }
    
    func delete(index: IndexSet) {
        cities.remove(atOffsets: index)
    }
}
