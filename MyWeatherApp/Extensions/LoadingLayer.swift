//
//  LoadingLayer.swift
//  MyWeatherApp
//
//  Created by abramovanto on 15.05.2024.
//

import SwiftUI

struct LoadingLayer: ViewModifier {
    var isLoading: Bool
    var backgroundColor: Color

    func body(content: Content) -> some View {
        if isLoading {
            ZStack {
                Color.init(backgroundColor)
                    .ignoresSafeArea()
                ProgressView()
                    .scaleEffect(2, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        } else {
            content
        }
    }
}

extension View {
    func progress(isLoading: Bool, backgroundColor: Color) -> some View {
        modifier(LoadingLayer(isLoading: isLoading, backgroundColor: backgroundColor))
    }
}
