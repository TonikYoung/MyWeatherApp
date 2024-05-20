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

//Дженерик способный принимать любое значение (строка, бул, инт и прочее)
@propertyWrapper 
struct GenericStorage<Value> {

    var wrappedValue: Value {
        get {
                    let value = storage.value(forKey: key) as? Value
                    return value ?? defaultValue
                }
                set {
                    storage.setValue(newValue, forKey: key)
                }
            }
    
    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults
    
    init(
        wrappedValue defaultValue: Value,
        key: String,
        storage: UserDefaults = .standard
    ) {
         self.defaultValue = defaultValue
         self.key = key
         self.storage = storage
     }
}

class GenericAppData {
    @GenericStorage(key: "some_city_name")
    var city = ""
}



 
