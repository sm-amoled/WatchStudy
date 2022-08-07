//
//  WeatherModel.swift
//  2_WeatherApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/07.
//

import Foundation

struct WeatherResponse: Codable {
    var forcase: [WeatherModel]
}
