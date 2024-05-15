//
//  CityItem.swift
//  MyWeatherApp
//
//  Created by abramovanto on 13.05.2024.
//

import Foundation

struct CityItem: Identifiable, Equatable {
    var cityName: String
    var id = UUID()
}
