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
    @Published var backgroundColor = Color("BaseViewColor")
    @GenericStorage(key: "listOfCities") var citiesStorage = Data()

    init() {
       /* guard let fetchedData = UserDefaults.standard.data(forKey: "citiesList") else {
            return
        }*/
        do {
            let fetchedCities = try PropertyListDecoder().decode([CityItem].self, from: citiesStorage)
            cities = fetchedCities
        } catch {
            print("Error while decoding cities")
        }
    }

    func add(name: String) {
        let newCity = CityItem(name: name)
        cities.append(newCity)
        saveData()
    }

    func delete(index: IndexSet) {
        cities.remove(atOffsets: index)
        //UserDefaults.standard.removeObject(forKey: "citiesList")
        saveData()
    }

    func saveData() {
        do {
            let citiesData = try PropertyListEncoder().encode(cities)
            citiesStorage = citiesData
            //UserDefaults.standard.set(citiesData, forKey: "citiesList")
        } catch {
            print("Error while decoding")
        }
    }
}
