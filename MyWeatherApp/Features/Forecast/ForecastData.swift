import SwiftUI
import Foundation

struct Weather: Codable {
    var location: Location
    var forecast: Forecast
}

struct Location: Codable {
    var name: String
}

struct Forecast: Codable {
    var forecastDay: [ForecastDay]

    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}

struct ForecastDay: Codable, Identifiable {
    var date: Int
    var day: Day
    var hour: [Hour]
    var id: Int { date }

    enum CodingKeys: String, CodingKey {
        case date = "date_epoch"
        case day
        case hour
    }
}

struct Day: Codable {
    var avgTemp: Double
    var maxWindKph: Double
    var totalPreciption: Double
    var chanceOfRain: Int
    var humidityAverage: Int
    var uv: Double
    var visAverage: Double
    var condition: Condition

    enum CodingKeys: String, CodingKey {
        case avgTemp = "avgtemp_c"
        case maxWindKph = "maxwind_kph"
        case totalPreciption = "totalprecip_mm"
        case chanceOfRain = "daily_chance_of_rain"
        case humidityAverage = "avghumidity"
        case uv
        case visAverage = "avgvis_km"
        case condition
    }
}

struct Condition: Codable {
    var text: String
    var code: Int
}

struct Hour: Codable, Identifiable {
    var timeDate: Int
    var time: String
    var temp: Double
    var condition: Condition
    var feelsLike: Double
    var id: Int { timeDate }

    enum CodingKeys: String, CodingKey {
        case timeDate = "time_epoch"
        case time
        case temp = "temp_c"
        case condition
        case feelsLike = "feelslike_c"
    }
}
