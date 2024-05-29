//
//  ForecastModel.swift
//  MyWeatherApp
//
//  Created by abramovanto on 22.05.2024.
//

import Foundation


struct ForecastModel {

    /*func loadWeatherData(query: String, completion: @escaping (Result<Weather, Error>) -> Void) {
     let urlString = "http://api.weatherapi.com/v1/forecast.json?key=b5c6cfaa09514caca4e185212240205&q=\(query)&days=3&aqi=no&alerts=no"
     guard let url = URL(string: urlString) else { return }
     URLSession.shared.dataTask(with: url) { (data, response, error) in
     DispatchQueue.main.async {
     if let error = error {
     completion(.failure(error))
     return
     }
     do {
     let result = try JSONDecoder().decode(Weather.self, from: data!)
     completion(.success(result))
     }
     catch let jsonError {
     completion(.failure(jsonError))
     }
     }
     }
     .resume()
     }
     */

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
        weatherNetworkManager.get(scheme: scheme, host: host, path: path, params: [idKey : userId, cityKey : query, daysKey : daysCount, aqiKey : aqiValue, alertsKey : alertsValue], completion: {(result: Result<Weather, Error>) in })

    }
}
