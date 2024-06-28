//
//  LocationManager.swift
//  MyWeatherApp
//
//  Created by abramovanto on 03.06.2024.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    @Published var status: CLAuthorizationStatus?
    @Published var location: CLLocation?
    @Published var placemark: CLPlacemark?

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        startTracking()
    }

    private func geocode() {
        guard let location else {
            return
        }

        geocoder.reverseGeocodeLocation(location) { [weak self] (places, error) in
            guard let self else {
                return
            }
            placemark = error == nil ? places?.first : nil
        }
    }

    func startTracking() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        geocode()
        if self.placemark != nil {
            self.locationManager.stopUpdatingLocation()
        }
    }
}

extension CLLocation {
    var latitude: Double {
        return coordinate.latitude
    }

    var longitude: Double {
        return coordinate.longitude
    }
}
