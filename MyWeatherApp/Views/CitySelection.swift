//
//  CitySelection.swift
//  MyWeatherApp
//
//  Created by abramovanto on 13.05.2024.
//

import SwiftUI

struct CitySelection: View {
    
    @Binding var backgroundColor: Color
    @ObservedObject var viewModel = CityListViewModel()
    @State private var userInput = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField("Введите название города", text: $userInput)
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(
                        Rectangle()
                            .foregroundColor(.white.opacity(0.2))
                            .cornerRadius(25)
                            .frame(height: 50)
                    )
                    .padding(.leading, 20)
                    .padding(.trailing, 5)
                    .padding(.bottom, 15)
                    .padding(.top, 15)
                    .multilineTextAlignment(.center)
                    .accentColor(.white)
                    .font(Font.system(size: 20, design: .default))
                
                    .onSubmit {
                        viewModel.add(name: userInput)
                        userInput = ""
                    }
                
                List {
                    ForEach(viewModel.cities) { city in
                        Text(city.cityName)
                    }
                    .onDelete(perform: viewModel.delete(index:))
                    .listRowBackground(Color.white.blur(radius: 75).opacity(0.5))
                }
                .contentMargins(.vertical, 0)
                .scrollContentBackground(.hidden)
                .preferredColorScheme(.dark)
                
                
            }

            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(backgroundColor)
        }

    }
}




#Preview {
    CitySelection(backgroundColor: .constant(.blue))
}
