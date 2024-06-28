//
//  ForecastModel.swift
//  MyWeatherApp
//
//  Created by abramovanto on 22.05.2024.
//

import Foundation

struct ForecastModel {
    var weatherNetworkManager = NetworkManager()
    var scheme = "http"
    var host = "api.weatherapi.com"
    var path = "/v1/forecast.json"
    var idKey = "key"
    var userId = "b5c6cfaa09514caca4e185212240205"
    var cityKey = "q"
    var daysKey = "days"
    var daysCount = "3"
    var aqiKey = "aqi"
    var aqiValue = "no"
    var alertsKey = "alerts"
    var alertsValue = "no"

    func loadWeather(query: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        weatherNetworkManager.get(
            scheme: scheme,
            host: host,
            path: path,
            params: [
                idKey: userId,
                cityKey: query,
                daysKey: daysCount,
                aqiKey: aqiValue,
                alertsKey: alertsValue
            ], 
            completion: { result in completion(result) }
        )
    }
}
