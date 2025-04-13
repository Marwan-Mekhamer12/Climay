//
//  WeatherData.swift
//  Climay
//
//  Created by Marwan Mekhamer on 13/04/2025.
//

import Foundation

struct WeatherData: Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}


struct Main: Codable {
    let temp : Double
    
}


struct Weather: Codable {
    let id : Int
}
