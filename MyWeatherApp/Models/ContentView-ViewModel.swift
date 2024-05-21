//
//  ContentView-ViewModel.swift
//  MyWeatherApp
//
//  Created by abramovanto on 21.05.2024.
//
import Alamofire
import Foundation
import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var results = [ForecastDay]()
    @Published var appData = GenericAppData()
    @Published var currentTemp = 0
    @Published var hourlyForecast = [Hour]()
    @Published var backgroundColor = Color.init(red: 47/255, green: 79/255, blue: 79/255)
    @Published var weatherEmoji = "🌨️"
    @Published var isLoading = true
    @Published var query: String = ""
    @Published var defaultCityName = ""

    func fetchWeather(query: String) async {
        var queryText = ""
        queryText = "http://api.weatherapi.com/v1/forecast.json?key=b5c6cfaa09514caca4e185212240205&q=\(query)&days=3&aqi=no&alerts=no"
        let request = AF.request(queryText)
        request.responseDecodable(of: Weather.self) { [self] response in
            switch response.result {
            case .success(let weather):
                results = weather.forecast.forecastday
                var index = 0
                if Date(timeIntervalSince1970: TimeInterval(results[0].date_epoch)).formatted(Date.FormatStyle().weekday(.abbreviated)) != Date().formatted(Date.FormatStyle().weekday(.abbreviated)) {
                    index = 1
                }
                appData.city = weather.location.name
                currentTemp = Int(results[index].day.avgtemp_c)
                hourlyForecast = results[index].hour
                backgroundColor = getBackgroundColor(code: results[index].day.condition.code)
                weatherEmoji = getWeatherEmoji(code: results[index].day.condition.code)
                isLoading = false
            case .failure(let error):
                print(error)
            }
        }
    }

    func loadingTask() {
        Task {
            if appData.city.isEmpty {
                defaultCityName = "Москва"
            } else {
                defaultCityName = appData.city
            }
            await fetchWeather(query: defaultCityName)
        }
    }
}
