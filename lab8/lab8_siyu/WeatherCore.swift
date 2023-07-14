//
//  Weather.swift
//  lab8_siyu
//
//  Created by user on 2023-03-14.
//

import Foundation
import UIKit

class WeatherCore {
    private let jsonDecoder = JSONDecoder()
    private var APP: ViewController?
    // mapping the image name with system icons
    private let weatherImages = [
        "clear-day": "cloud.sun",
        "clear-night": "cloud.moon",
        "clouds": "cloud",
        "rain": "cloud.rain",
        "drizzle": "cloud.rain",
        "snow": "snow",
        "thunderstorm": "cloud.bolt",
        "mist": "cloud.fog",
        "smoke": "smoke",
        "dust": "smoke",
        "ash": "smoke",
        "haze-day": "sun.haze",
        "haze-night": "moon.haze",
        "fog": "cloud.fog",
        "squall": "wind",
        "tornado": "wind",
        "undefined": "questionmark.circle",
    ]
    private let Kelvins = -273.15
    public var weather: Welcome? {
        willSet {
            // UIView can only be flushed in main thread
            DispatchQueue.main.async {
                let weather_image_systemName = self.GetIconName(newValue)
                let weather_info = (
                    location: newValue!.name,
                    weather: newValue!.weather[0].main,
                    temperature: String(format: "%.2f", newValue!.main.temp + self.Kelvins) + "°C",
                    humidity: "Humidity: \(newValue!.main.humidity)%",
                    windspeed: "Wind: \(newValue!.wind.speed)km/h",
                    image: UIImage(systemName: weather_image_systemName)!
                )
                self.APP?.app_state = weather_info
            }
        }
    }

    // get icon's name from the dict
    private func GetIconName(_ newValue: Welcome?) -> String {
        let lowercased_weather = newValue!.weather[0].main.lowercased()
        // some icons have two versions
        let is_night = newValue!.sys.sunset > newValue!.sys.sunrise ? true : false
        switch lowercased_weather {
        case "clear":
            if is_night {
                return weatherImages["clear-night"]!
            }
            return weatherImages["clear-day"]!
        case "haze":
            if is_night {
                return weatherImages["haze-night"]!
            }
            return weatherImages["haze-day"]!
        default:
            if let weather_image_name = weatherImages[lowercased_weather] {
                return weather_image_name
            }
            return weatherImages["undefined"]!
        }
    }

    // get api request and decode
    func GetWeather(from api: String) {
        print(api)
        if let API = URL(string: api) {
            let urlSession = URLSession(configuration: .default)
            let dataTask = urlSession.dataTask(with: API) {
                data, _, error in
                if error == nil, data != nil {
                    if let decoded_data = try? self.jsonDecoder.decode(Welcome.self, from: data!) {
                        self.weather = decoded_data
                    } else {
                        print("decode error")
                    }
                } else {
                    print("request error")
                }
            }
            dataTask.resume()
        } else {
            print("url error")
        }
    }

    init(app: ViewController) {
        // get the instance of the controller
        APP = app
    }
}
