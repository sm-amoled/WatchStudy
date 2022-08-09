//
//  WatchWeatherView.swift
//  2_WeatherApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/09.
//

import SwiftUI

struct WatchWeatherView: View {
    
    @ObservedObject private var locationManager = WeatherLocationManager()
    @ObservedObject private var weatherManager = WeatherManager()
    
    var body: some View {
        ZStack {
            OutlineView()
            VStack(alignment: .center) {
                HStack {
                    Text(locationManager.cityName)
                        .lineLimit(1)
                    .minimumScaleFactor(0.005)
                    
                    Image(systemName: "paperplane.fill")
                        .font(.caption)
                }
                
                Image(systemName: weatherManager.weatherResponse.forecast.first?.conditions ?? "sun.min")
                    .font(.title)
                    .foregroundColor(.yellow)
                
                Text(weatherManager.weatherResponse.forecast.first?.description ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Text("\(String(format: "%0.0f", FtoC(F: weatherManager.weatherResponse.forecast.first?.temperature ?? 0.0)))℃")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .shadow(color: Color.white.opacity(0.2), radius: 2, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x:  2, y:  2)
        }
        .onReceive(locationManager.$cityName) { _ in
            weatherManager.getWeather(for: WeatherCoordinates(lat: locationManager.coordinate.latitude,
                                                              lon: locationManager.coordinate.longitude))
        }
    }
    
    private func FtoC(F: Double) -> Double {
        return (F-32) * 5 / 9
    }
}

struct WatchWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WatchWeatherView()
    }
}
