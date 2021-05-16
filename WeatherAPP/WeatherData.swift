//
//  Model.swift
//  WeatherAPP
//
//  Created by Noor Rassam on 2020-12-10.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let sys: Country1
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let id: Int
    let icon : String
}

struct Country1: Codable {
    let country: String
}
