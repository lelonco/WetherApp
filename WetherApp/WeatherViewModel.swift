//
//  WeatherViewModel.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    private let wetherManager = WetherManager()
    @Published var weather: WetherResponse?
    @Published var isLoading = false
    @Published var location: CLLocationCoordinate2D?
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }

    func getWeather() {
        guard let lat = location?.latitude,
              let lon = location?.longitude else { return }
        Task { [unowned self] in
            do {
                weather = try await wetherManager.getCurrentWether(lat: lat, lon: lon)
            } catch {
                print("Recieve an error:", error)
            }
        }
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
//        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error!: ", error)
        isLoading = false
    }

}
