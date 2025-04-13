//
//  ViewController.swift
//  Climay
//
//  Created by Marwan Mekhamer on 13/04/2025.
//

// api key: 4ba21d103e828d7bcfbaa4ddc2fe2396

import UIKit
import CoreLocation

class ViewController: UIViewController {
    

    @IBOutlet weak var CondetionimageView: UIButton!
    @IBOutlet weak var searchtxt: UITextField!
    @IBOutlet weak var templbl: UILabel!
    @IBOutlet weak var cityNamelbl: UILabel!
    
    var weather = WeatherManager()
    var locationmanager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.requestLocation()
        weather.delegate = self
        searchtxt.delegate = self
        
    }
    
    @IBAction func locationPressed(_ sender: Any) {
        locationmanager.requestLocation()
    }
    
    @IBAction func searchbtn(_ sender: UIButton) {
        let cityname = searchtxt.text!
        cityNamelbl.text = cityname
        view.endEditing(true)
    }
    
    
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let cityName = searchtxt.text!
        cityNamelbl.text = cityName
        view.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Typing something"
            return false
        }
    }
    
    
    // i will start write in note from here :-> Smile marwan🥲
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // user textfield.text to go the weather
        if let city = searchtxt.text{
            weather.fetchurl(city)
        }
        
        searchtxt.text = ""
        textField.placeholder = "Search"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ViewController: weathermanagerDelegate {
    
    func didupdate(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.templbl.text = weather.tempreture
            self.cityNamelbl.text = weather.cityname
            self.CondetionimageView.setImage(UIImage(systemName: weather.condentionName), for: .normal)
        }
    }
    
    func didError(_ error: Error) {
        if let cityname = cityNamelbl.text {
            DispatchQueue.main.async {
                self.cityNamelbl.text = "Error\(error.localizedDescription), The \(cityname) is not found! Try again..."
                self.CondetionimageView.setImage(UIImage(systemName: "trash"), for: .normal)
                self.templbl.text = "None!"
            }
        }
    }
    
    
}

//Mark: - CLLocationManagerDelegate

extension ViewController : CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationmanager.stopUpdatingLocation()
            let lot = location.coordinate.longitude
            let lat = location.coordinate.latitude
            weather.fetchWeahercoord(lot: lot, lat: lat)
            print(lot)
            print(lat)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("The Location does not using in this LapTop. \(error)")
    }
    
    
    
}
