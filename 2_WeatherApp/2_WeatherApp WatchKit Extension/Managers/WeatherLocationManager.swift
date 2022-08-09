//
//  LocationManager.swift
//  2_WeatherApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/07.
//

import Foundation
import CoreLocation

final class WeatherLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var cityName = "Pohang"
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 36.01969207188155, longitude: 129.34246431044176)
    
    private var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // array의 last element에 가장 최근의 location이 들어있음
        guard let location = locations.last else { return }
        coordinate = location.coordinate
        
        getCityForCoordinates(location: coordinate)
    }
    
    private func getCityForCoordinates(location: CLLocationCoordinate2D) {
        let url = URL(string: "https://api.bigdatacloud.net/data/reverse-geocode?latitude=\(location.latitude)&longitude=\(location.longitude)&localityLanguage=en&key=[bdc_c4f34aac159b424a8954be5e1aba4fff]")!
        NetworkManager<CityModel>().fetch(for: url) { (result) in
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let cityData):
                self.cityName = "\(cityData.city), \(cityData.countryCode)"
            }
        }
    }
}
