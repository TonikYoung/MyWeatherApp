//
//  UserDefaults.swift
//  MyWeatherApp
//
//  Created by abramovanto on 16.05.2024.
//

import SwiftUI
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
