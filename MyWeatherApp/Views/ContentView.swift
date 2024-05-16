
import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State private var results = [ForecastDay]()
    @State private var hourlyForecast = [Hour]()
    @State private var query: String = ""
    @State private var contentSize: CGSize = .zero
    @State private var backgroundColor = Color.init(red: 47/255, green: 79/255, blue: 79/255)
    @State private var weatherEmoji = "🌨️"
    @State private var currentTemp = 0
    @State private var cityName = UserDefaults.standard.string(forKey: "LastSearched")
    @State private var isLoading = true
    
    
    var body: some View {
        //if isLoading {
        //   loadingView
        //} else {
        NavigationView {
            VStack {
                searchLayer
                currentWeatherLayer
                dailyForecastLayer
                furuteForecastLayer
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(backgroundColor)
        }
        .progress(isLoading: isLoading, backgroundColor: backgroundColor)
        .onAppear {
            Task {
                await fetchWeather(query: "", name: cityName ?? "Москва")
            }
        }
        .accentColor(.white)
    }
    
    var currentWeatherLayer: some View {
        VStack{
            Text("\(String(describing: cityName ?? ""))")
                .modeText(textSize: 35)
                .bold()
            Group {
                Text("\(Date().formatted(date: .numeric, time: .omitted))")
                Text("\(getTranslatedDate(date: (Date().formatted(date: .complete, time: .omitted))))")
            }
            .modeTextView(size: 16)
            Text(weatherEmoji)
                .modeText(textSize: 120)
            Text("\(currentTemp)°C")
                .modeText(textSize: 50)
            Spacer()
        }
    }
    
    /* var loadingView: some View {
     ZStack {
     Color.init(backgroundColor)
     .ignoresSafeArea()
     ProgressView()
     .scaleEffect(2, anchor: .center)
     .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
     .frame(maxWidth: .infinity, maxHeight: .infinity)
     .task {
     await fetchWeather(query: "")
     }
     }
     }
     */
    
    var searchLayer: some View {
        HStack {
            TextField("Введите название города", text: $query)
                .modeTextField()
                .onSubmit {
                    Task {
                        await fetchWeather(query: query, name: cityName!)
                        query = ""
                    }
                }
            NavigationLink(destination: CitySelection(currentCityName: cityName ?? "Москва", backgroundColor: backgroundColor) , label: {
                Image(systemName: "plus.magnifyingglass")
                    .font(.system(size: 40))
            })
            Spacer()
        }
    }
    
    var dailyForecastLayer: some View {
        VStack {
            Text("Прогноз на весь день")
                .modeHeaderText(textSize: 17)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                    ForEach(hourlyForecast) { forecast in
                        VStack {
                            Text("\(getShortTime(time: forecast.time))")
                            Text("\(getWeatherEmoji(code:forecast.condition.code))")
                            Text("\(Int(forecast.temp_c))°C")
                        }
                        .modeTextView(size: 16)
                        .frame(width: 50, height: 90)
                    }
                    Spacer()
                }
                .background(Color.white.blur(radius: 75).opacity(0.35))
                .cornerRadius(15)
            }
            .padding(.top, .zero)
            .padding(.leading, 18)
            .padding(.trailing, 18)
            Spacer()
        }
    }
    
    var furuteForecastLayer: some View {
        VStack{
            Text("Прогноз на 3 дня")
                .modeHeaderText(textSize: 17)
            List {
                ForEach(Array(results.enumerated()), id: \.1.id) { index, forecast in
                    HStack(alignment: .center, spacing: 100) {
                        Text("\(getShortDate(epoch: forecast.date_epoch))")
                        Text("\(getWeatherEmoji(code: forecast.day.condition.code))")
                        Text("\(Int(forecast.day.avgtemp_c))°C")
                    }
                    .modeTextView(size: 17)
                    
                }
                .listRowBackground(Color.white.blur(radius: 75).opacity(0.5))
            }
            .contentMargins(.vertical, 0)
            .scrollContentBackground(.hidden)
            .preferredColorScheme(.dark)
        }
    }
    
    
    
    
    func fetchWeather(query: String, name: String) async {
        var queryText = ""
        if (name == "" ) && (query == ""){
            queryText = "http://api.weatherapi.com/v1/forecast.json?key=b5c6cfaa09514caca4e185212240205&q=Москва&days=3&aqi=no&alerts=no"
        } else if (name != "") && (query == "") {
            queryText = "http://api.weatherapi.com/v1/forecast.json?key=b5c6cfaa09514caca4e185212240205&q=\(name)&days=3&aqi=no&alerts=no"
        } else {
            queryText = "http://api.weatherapi.com/v1/forecast.json?key=b5c6cfaa09514caca4e185212240205&q=\(query)&days=3&aqi=no&alerts=no"
        }
        let request = AF.request(queryText)
        request.responseDecodable(of: Weather.self) { response in
            switch response.result {
            case .success(let weather):
                //dump(weather)
                results = weather.forecast.forecastday
                var index = 0
                if Date(timeIntervalSince1970: TimeInterval(results[0].date_epoch)).formatted(Date.FormatStyle().weekday(.abbreviated)) != Date().formatted(Date.FormatStyle().weekday(.abbreviated)) {
                    index = 1
                }
                cityName = weather.location.name
                currentTemp = Int(results[index].day.avgtemp_c)
                hourlyForecast = results[index].hour
                backgroundColor = getBackgroundColor(code: results[index].day.condition.code)
                weatherEmoji = getWeatherEmoji(code: results[index].day.condition.code)
                UserDefaults.standard.set(cityName, forKey: "LastSearched")
                
                isLoading = false
            case .failure(let error):
                print(error)
            }
        }
    }
}



#Preview {
    ContentView()
}
