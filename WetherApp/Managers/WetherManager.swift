//
//  WetherManager.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import Foundation
import CoreLocation

class WetherManager {
    
    
    private let apiKey = "d11bc8cfc7d953b7e7aa14df406d8025"
    private let limit = 10
    
    func getCity(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> CityModel? {
        let stringURL = "http://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=\(limit)&appid=\(apiKey)"
        guard let url = URL(string: stringURL) else {
            print("Can't create url with such parameters")
            throw NetworkManager.Errors.invalidURL
        }
        
        let cities = try await NetworkManager.fetch(request: url, decodeTo: [CityModel].self)
        return cities.first
    }
    
    func getCurrentWether(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> WetherResponse {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            print("Can't create url")
            throw NetworkManager.Errors.invalidURL
        }
        
        return try await NetworkManager.fetch(request: url, decodeTo: WetherResponse.self)
    }
    
    func getCurrentWether(city: CityModel) async throws -> WetherResponse  {
        
        guard let cityName = city.name else {
            throw NetworkManager.Errors.missingReqParameters
        }
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric") else {
            print("Can't create url")
            throw NetworkManager.Errors.invalidURL
        }
        
        return try await NetworkManager.fetch(request: url, decodeTo: WetherResponse.self)
    }
}

struct WetherResponse: Decodable {
    struct Wether: Decodable {
        let id: Int?
        let main: String?
        let description: String?
        let icon: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case main
            case description
            case icon
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case name
    }
    
    enum MainCodingKeys: String, CodingKey {
        case temp
        case feelsLike
        case tempMin
        case tempMax
        case pressure
        case humidity
        case seaLevel
        case grndLevel
    }
    
    let weather: [Wether]?
    let name: String?
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let humidity: Double?
    let seaLevel: Double?
    let grndLevel: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WetherResponse.CodingKeys.self)
        self.weather = try container.decodeIfPresent([Wether].self, forKey: CodingKeys.weather)
        self.name = try container.decodeIfPresent(String.self, forKey: CodingKeys.name)
        let main = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: CodingKeys.main)
        self.temp = try main.decodeIfPresent(Double.self, forKey: MainCodingKeys.temp)
        self.feelsLike = try main.decodeIfPresent(Double.self, forKey: MainCodingKeys.feelsLike)
        self.tempMin = try main.decodeIfPresent(Double.self, forKey: MainCodingKeys.tempMin)
        self.tempMax = try main.decodeIfPresent(Double.self, forKey: MainCodingKeys.tempMax)
        self.pressure = try main.decodeIfPresent(Double.self, forKey: MainCodingKeys.pressure)
        self.humidity = try main.decodeIfPresent(Double.self, forKey: MainCodingKeys.humidity)
        self.seaLevel = try main.decodeIfPresent(Double.self, forKey: MainCodingKeys.seaLevel)
        self.grndLevel = try main.decodeIfPresent(Double.self, forKey: MainCodingKeys.grndLevel)
    }
}

struct CityModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case localNames
        case country
    }
    
    private struct LocalNames: Decodable {
        enum CodingKeys: String, CodingKey {
            case ar
            case ascii
            case bg
            case ca
            case de
            case el
            case en
            case fa
            case feature_name
            case fi
            case fr
            case gl
            case he
            case hi
            case id
            case it
            case ja
            case la
            case lt
            case pt
            case ru
            case sr
            case th
            case tr
            case vi
            case zu
        }
 
        let ar: String?
        let ascii: String?
        let bg: String?
        let ca: String?
        let de: String?
        let el: String?
        let en: String?
        let fa: String?
        let feature_name: String?
        let fi: String?
        let fr: String?
        let gl: String?
        let he: String?
        let hi: String?
        let id: String?
        let it: String?
        let ja: String?
        let la: String?
        let lt: String?
        let pt: String?
        let ru: String?
        let sr: String?
        let th: String?
        let tr: String?
        let vi: String?
        let zu: String?
    }
    
    let name: String?
    let country: String?
    let engName: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decodeIfPresent(String.self, forKey: .name)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        let locaNames = try container.nestedContainer(keyedBy: LocalNames.CodingKeys.self, forKey: .localNames)
        engName = try locaNames.decodeIfPresent(String.self, forKey: LocalNames.CodingKeys.en)
    }
}
