
import SwiftUI
import Alamofire

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                searchLayer
                currentWeatherLayer
                dailyForecastLayer
                furuteForecastLayer
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(viewModel.backgroundColor)
        }
        .progress(isLoading: viewModel.isLoading, backgroundColor: viewModel.backgroundColor)
        .onAppear {
            viewModel.loadingTask()
        }
        .accentColor(.white)
    }
    
    var currentWeatherLayer: some View {
        VStack{
            Text(viewModel.appData.city)
                .modeText(textSize: 35)
                .bold()
            Group {
                Text("\(Date().formatted(date: .numeric, time: .omitted))")
                Text("\(getTranslatedDate(date: (Date().formatted(date: .complete, time: .omitted))))")
            }
            .modeTextView(size: 16)
            Text(viewModel.weatherEmoji)
                .modeText(textSize: 120)
            Text("\(viewModel.currentTemp)°C")
                .modeText(textSize: 50)
            Spacer()
        }
    }
    
    var searchLayer: some View {
        HStack {
            TextField("Введите название города", text: $viewModel.query)
                .modeTextField()
                .onSubmit {
                    Task {
                        await viewModel.fetchWeather(query: viewModel.query)
                        viewModel.query = ""
                    }
                }
            NavigationLink(destination: CitySelection(currentCityName: viewModel.appData.city, backgroundColor: viewModel.backgroundColor) , label: {
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
                    ForEach(viewModel.hourlyForecast) { forecast in
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
                ForEach(Array(viewModel.results.enumerated()), id: \.1.id) { index, forecast in
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
}

#Preview {
    ContentView()
}
