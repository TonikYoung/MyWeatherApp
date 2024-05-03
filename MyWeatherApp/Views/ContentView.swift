
import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State var results = [ForecastDay]()
    @State var hourlyForecast = [Hour]()
    @State var query: String = ""
    @State var contentSize: CGSize = .zero
    @State var textFieldHeight = 15.0
    @State var backgroundColor = Color.init(red: 47/255, green: 79/255, blue: 79/255)
    @State var weatherEmoji = "🌨️"
    @State var currentTemp = 0
    @State var cityName = "Москва"
    @State var loading = true
        
    var body: some View {
        if loading {
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
        } else {
            NavigationView {
                VStack {
                    Spacer()
                    TextField("Введите название города", text: $query)
                        .textFieldStyle(PlainTextFieldStyle())
                        .background(
                            Rectangle()
                                .foregroundColor(.white.opacity(0.2))
                                .cornerRadius(25)
                                .frame(height: 50)
                        )
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                        .padding(.bottom, 15)
                        .padding(.top, textFieldHeight)
                        .multilineTextAlignment(.center)
                        .accentColor(.white)
                        .font(Font.system(size: 20, design: .default))
                        .onSubmit {
                            Task {
                                await fetchWeather(query: query)
                            }
                            withAnimation {
                                textFieldHeight = 15
                            }
                        }
                    Text("\(cityName)")
                        .font(.system(size: 35))
                        .foregroundStyle(.white)
                        .bold()
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                        .padding(.bottom, 1)
                    Text("\(Date().formatted(date: .numeric, time: .omitted))")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                    Text("\(getTranslatedDate(date: (Date().formatted(date: .complete, time: .omitted))))")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                    Text(weatherEmoji)
                        .font(.system(size: 110))
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                    Text("\(currentTemp)°C")
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Прогноз на весь день")
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                        .bold()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Spacer()
                            ForEach(hourlyForecast) { forecast in
                                VStack {
                                    Text("\(getShortTime(time: forecast.time))")
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                    Text("\(getWeatherEmoji(code:forecast.condition.code))")
                                        .frame(width: 50, height: 14)
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                    Text("\(Int(forecast.temp_c))°C")
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                }
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
                    Text("Прогноз на 3 дня")
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                        .bold()
                        .padding(.top, 12)
                    List {
                        ForEach(Array(results.enumerated()), id: \.1.id) { index, forecast in
                          
                                HStack(alignment: .center, spacing: 100) {
                                    Text("\(getShortDate(epoch: forecast.date_epoch))")
                                        .frame(maxWidth: 50, alignment: .leading)
                                        .bold()
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                    Text("\(getWeatherEmoji(code: forecast.day.condition.code))")
                                        .frame(maxWidth: 30, alignment: .leading)
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                    Text("\(Int(forecast.day.avgtemp_c))°C")
                                        .frame(maxWidth: 50, alignment: .leading)
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)

                                }
                            
                        }
                        .listRowBackground(Color.white.blur(radius: 75).opacity(0.5))
                    }
                    .contentMargins(.vertical, 0)
                    .scrollContentBackground(.hidden)
                    .preferredColorScheme(.dark)
                   
                    NavigationLink(destination: PlacesOfInterest() , label: {
                        Text("Посмотреть \n туристические объекты")
                            .lineLimit(2)
                            .font(.system(size: 17))
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                            .bold()
                            .padding(.top, 12)
                    })


                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background(backgroundColor)
            }
            .accentColor(.white)
        }
    }
    
    
    func fetchWeather(query: String) async {
        var queryText = ""
        if (query == "") {
            queryText = "http://api.weatherapi.com/v1/forecast.json?key=b5c6cfaa09514caca4e185212240205&q=Москва&days=3&aqi=no&alerts=no"
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

                
                loading = false
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
