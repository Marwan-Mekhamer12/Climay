//
//  WeatherManager.swift
//  Climay
//
//  Created by Marwan Mekhamer on 13/04/2025.
//

import Foundation
import CoreLocation

protocol weathermanagerDelegate {
    func didupdate(_ weather : WeatherModel)
    func didError(_ error : Error)
}

struct WeatherManager {
    
    var delegate : weathermanagerDelegate?
    
    let WeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4ba21d103e828d7bcfbaa4ddc2fe2396"
    
    func fetchWeahercoord(lot : CLLocationDegrees, lat : CLLocationDegrees) {
        let url = "\(WeatherURL)&lon=\(lot)&lan=\(lat)"
        preformRequest(url)
    }
    
    func fetchurl(_ cityname: String) {
        let url = "\(WeatherURL)&q=\(cityname)"
        preformRequest(url)
    }
    
    func preformRequest(_ urlstring: String) {
        if let url = URL(string: urlstring) {
            let Session = URLSession(configuration: .default)
            let task = Session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didError(error!)
                    return
                }
                
                if let saveData = data {
                    if let weather = self.pareseJSon(weatherData: saveData) {
                        self.delegate?.didupdate(weather)
                    }
                }
            }
            
            task.resume()
            
        }
    }
    
    func pareseJSon(weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityname = decoderData.name
            let id = decoderData.weather[0].id
            let temp = decoderData.main.temp
            let weather = WeatherModel(cityname: cityname, id: id, temp: temp)
            print(weather.cityname)
            print(weather.id)
            print(weather.temp)
            return weather
        } catch {
            delegate?.didError(error)
            return nil
        }
    }
}
