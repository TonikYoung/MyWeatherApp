//
//  TextExtensions.swift
//  MyWeatherApp
//
//  Created by abramovanto on 15.05.2024.
//

import Foundation
import SwiftUI

// Цвет, тень, размер шрифта
extension Text {
    func modeText(textSize: Int) -> some View {
        self.foregroundStyle(.white)
            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
            .font(.system(size: CGFloat(textSize)))
        
    }
}

extension Text {
    func modeHeaderText(textSize: Int) -> some View {
        self.foregroundStyle(.white)
            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
            .font(.system(size: CGFloat(textSize)))
            .bold()
            .padding(.top, 12)
            .lineLimit(2)
    }
}

extension View {
    func modeTextView(size: Int) -> some View {
        self.foregroundStyle(.white)
            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
            .font(.system(size: CGFloat(size)))
    }
}

extension TextField {
    func modeTextField() -> some View {
        self.textFieldStyle(PlainTextFieldStyle())
        .background(
            Rectangle()
                .foregroundColor(.white.opacity(0.2))
                .cornerRadius(25)
                .frame(height: 50)
        )
        .padding(.leading, 60)
        .padding(.trailing, 5)
        .padding(.bottom, 15)
        .padding(.top, 15)
        .multilineTextAlignment(.center)
        .accentColor(.white)
        .font(Font.system(size: 20, design: .default))
    }
}
