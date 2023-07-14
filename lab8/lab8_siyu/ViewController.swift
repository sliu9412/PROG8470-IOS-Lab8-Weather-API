//
//  ViewController.swift
//  lab8_siyu
//
//  Created by user on 2023-03-14.
//

import CoreLocation
import UIKit

class ViewController: UIViewController {
    @IBOutlet var LocationLabel: UILabel!
    @IBOutlet var WeatherLabel: UILabel!
    @IBOutlet var TempratureLabel: UILabel!
    @IBOutlet var HumidityLabel: UILabel!
    @IBOutlet var WindLabel: UILabel!
    @IBOutlet var WeatherImageView: UIImageView!

    private let api_key = "a634b11f55f******90a79404062a681"
    private var latitude = 43.4652699
    private var longitude = -80.5222961

    var app_state = (
        location: "",
        weather: "",
        temperature: "",
        humidity: "",
        windspeed: "",
        image: UIImage()
    ) {
        willSet {
            LocationLabel.text = newValue.location
            WeatherLabel.text = newValue.weather
            TempratureLabel.text = newValue.temperature
            HumidityLabel.text = newValue.humidity
            WindLabel.text = newValue.windspeed
            WeatherImageView.image = newValue.image
        }
    }

    // calculate property of the api
    var location_manager = CLLocationManager()
    private var new_api: String {
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(api_key)"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        location_manager.delegate = self
        location_manager.desiredAccuracy = kCLLocationAccuracyBest
        location_manager.requestWhenInUseAuthorization()
        location_manager.startUpdatingLocation()
        let weather_core = WeatherCore(app: self)
        weather_core.GetWeather(from: new_api)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
            let weather_core = WeatherCore(app: self)
            weather_core.GetWeather(from: new_api)
        }
    }
}
