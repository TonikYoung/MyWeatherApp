///
//  CitySelection.swift
//  MyWeatherApp
//
//  Created by abramovanto on 13.05.2024.
//

import SwiftUI

struct CitySelectionView: View {
    @ObservedObject var viewModel = CitySelectionViewModel()
    var currentCityName: String
    var backgroundColor: Color

    var body: some View {
        NavigationView {
            VStack {
                searchBar
                List {
                    listOfCities
                }
                .contentMargins(.vertical, 0)
                .scrollContentBackground(.hidden)
                .preferredColorScheme(.dark)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(backgroundColor)
        }
        .onAppear {
            viewModel.add(name: currentCityName)
        }
    }

    var searchBar: some View {
        TextField("Введите название города", text: $viewModel.userInput)
            .modeTextField()
            .padding(.trailing, 50)
            .onSubmit {
                viewModel.add(name: viewModel.userInput)
                viewModel.userInput = ""
            }
    }

    var listOfCities: some View {
        ForEach(viewModel.cities) { city in
            Text(city.cityName)
        }
        .onDelete(perform: viewModel.delete(index:))
        .listRowBackground(Color.white.blur(radius: 75).opacity(0.5))
    }
}

#Preview {
    CitySelectionView(currentCityName: "Москва", backgroundColor: .blue)
}
