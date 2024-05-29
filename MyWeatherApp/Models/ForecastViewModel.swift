//
//  ContentView-ViewModel.swift
//  MyWeatherApp
//
//  Created by abramovanto on 21.05.2024.
//
import Foundation
import SwiftUI

// модель для загрузки данных погоды
struct ForecastData: Identifiable {
    let date: String
    let condition: String
    let temperature: String
    let id = UUID()
}

final class ForecastViewModel: ObservableObject {
    @Published var results = [ForecastDay]()
    @Published var appData = GenericAppData()
    @Published var currentTemp = 0
    @Published var hourlyForecast = [ForecastData]()
    @Published var dailyForecast = [ForecastData]()
    @Published var backgroundColor = Color.init(red: 47/255, green: 79/255, blue: 79/255)
    @Published var weatherEmoji = "🌨️"
    @Published var isLoading = true
    @Published var query = ""
    @Published var defaultCityName = ""
    var forecastModelObject = ForecastModel()

    func fetchWeather(city: String) {
        forecastModelObject.loadWeather(query: city) { [self] result in
            switch result {
            case .success(let weather):
                results = weather.forecast.forecastDay
                var index = 0
                if Date(timeIntervalSince1970: TimeInterval(results[0].date)).formatted(Date.FormatStyle().weekday(.abbreviated)) != Date().formatted(Date.FormatStyle().weekday(.abbreviated)) {
                    index = 1
                }
                appData.city = weather.location.name
                currentTemp = Int(results[index].day.avgTemp)
                hourlyForecast = results[index].hour.map { item in
                    ForecastData.init(date: getShortTime(time: item.time), condition: getWeatherEmoji(code:item.condition.code), temperature: "\(Int(item.temp))°C")
                }
                dailyForecast = weather.forecast.forecastDay.map { item in
                    ForecastData.init(date: getShortDate(epoch: item.date), condition: getWeatherEmoji(code: item.day.condition.code), temperature: "\(Int(item.day.avgTemp))°C")
                }
                backgroundColor = getBackgroundColor(code: results[index].day.condition.code)
                weatherEmoji = getWeatherEmoji(code: results[index].day.condition.code)
                isLoading = false
            case .failure(let error):
                print(error)
            }
        }
    }

    func loadingTask() {
        if appData.city.isEmpty {
            defaultCityName = "Москва"
        } else {
            defaultCityName = appData.city
        }
        fetchWeather(city: defaultCityName)
    }

    func searchTask() {
        fetchWeather(city: query)
        query = ""
    }
}
