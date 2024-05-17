//
//  UserDefaults.swift
//  MyWeatherApp
//
//  Created by abramovanto on 16.05.2024.
//

import SwiftUI

@propertyWrapper
struct Storage {
  
    private let key: String
    private let defaultValue: String
    
    init(key: String, defaultValue: String) {
        self.key = key
        self.defaultValue = defaultValue
    }
        
    var wrappedValue: String {
        get {
            // Читаю значение
            return UserDefaults.standard.string(forKey: key) ?? defaultValue
        }
        set {
            // Устанавливаю значение
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

class AppData {
    @Storage(key: "city_key", defaultValue: "")
    var city: String
}
