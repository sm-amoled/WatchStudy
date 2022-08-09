//
//  WeatherManager.swift
//  2_WeatherApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/07.
//

import Foundation
import Combine

final class WeatherManager: ObservableObject {
    @Published var weatherResponse = WeatherResponse(forecast: [])
    
    func getWeather(for coord: WeatherCoordinates) {
        
    
        let url = URL(string: "https://api.lil.software/weather?latitude=\(coord.lat)&longitude=\(coord.lon)")!
        NetworkManager<WeatherResponse>().fetch(for: url) { (result) in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let resp):
                self.weatherResponse = resp
            }
        }
    }
}
