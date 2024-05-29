
import SwiftUI

struct ForecastView: View {
    @StateObject private var forecastViewModel = ForecastViewModel()

    var body: some View {
        NavigationView {
            VStack {
                searchWeather
                currentWeather
                dailyForecastWeather
                furuteForecastWeather
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(forecastViewModel.backgroundColor)
        }
        .progress(isLoading: forecastViewModel.isLoading, backgroundColor: forecastViewModel.backgroundColor)
        .onAppear {
            forecastViewModel.loadingTask()
        }
        .accentColor(.white)
    }

    var searchWeather: some View {
        HStack {
            TextField("Введите название города", text: $forecastViewModel.query)
                .modeTextField()
                .onSubmit {
                    forecastViewModel.searchTask()
                }
            NavigationLink(destination: CitySelectionView(currentCityName: forecastViewModel.appData.city, backgroundColor: forecastViewModel.backgroundColor) , label: {
                Image(systemName: "plus.magnifyingglass")
                    .font(.system(size: 40))
            })
            Spacer()
        }
    }

    var currentWeather: some View {
        VStack{
            Text(forecastViewModel.appData.city)
                .modeText(textSize: 35)
                .bold()
            Group {
                Text("\(Date().formatted(date: .numeric, time: .omitted))")
                Text("\(getTranslatedDate(date: (Date().formatted(date: .complete, time: .omitted))))")
            }
            .modeTextView(size: 16)
            Text(forecastViewModel.weatherEmoji)
                .modeText(textSize: 120)
            Text("\(forecastViewModel.currentTemp)°C")
                .modeText(textSize: 50)
            Spacer()
        }
    }

    var dailyForecastWeather: some View {
        VStack {
            Text("Прогноз на весь день")
                .modeHeaderText(textSize: 17)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                    ForEach(forecastViewModel.hourlyForecast) { forecast in
                        VStack {
                            Text(forecast.date)
                            Text(forecast.condition)
                            Text(forecast.temperature)
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

    var furuteForecastWeather: some View {
        VStack{
            Text("Прогноз на 3 дня")
                .modeHeaderText(textSize: 17)
            List {
                ForEach(forecastViewModel.dailyForecast) { forecast in
                    HStack(alignment: .center, spacing: 100) {
                        Text(forecast.date)
                        Text(forecast.condition)
                        Text(forecast.temperature)
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
    ForecastView()
}
