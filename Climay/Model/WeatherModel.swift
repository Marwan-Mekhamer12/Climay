//
//  WeatherModel.swift
//  Climay
//
//  Created by Marwan Mekhamer on 13/04/2025.
//

import Foundation

struct WeatherModel {
    let cityname : String
    let id : Int
    let temp : Double
    
    var tempreture : String{
        return String(format: "%.1f", temp)
    }
    
    var condentionName : String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
            
        }

    }
}
