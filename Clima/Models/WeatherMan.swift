//
//  WeatherMan.swift
//  Clima
//
//  Created by Parsa Jabbari on 9/1/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManDelegate {
    func didUpdateWeather(_ weatherManager: WeatherMan, _ weather: Weather)
    
    func didFailWithError(_ weatherManager: WeatherMan, _ error: Error)
}

struct WeatherMan {
    let url = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=29606fd5cffc0c47ba9999dfa48db795"
    var delegate: WeatherManDelegate?
    
    func getWeather(_ city: String) {
        let getURL = "\(url)&q=\(city)"
        performRequest(urlString: getURL)
    }
    
    func getWeather(lat: Double, lon: CLLocationDegrees) {
        let getURL = "\(url)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString: getURL)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let sessionTask = session.dataTask(with: url) { (data, response, error) in
                if let safeData = data {
                    if let weather = parseJSON(weatherData: safeData) {
                        delegate?.didUpdateWeather(self, weather)
                    }
                } else {
                    delegate?.didFailWithError(self, error!)
                    return
                }
            }
            sessionTask.resume()
        } else {
            return
        }
    }
    
    func parseJSON(weatherData: Data) -> Weather? {
        print(weatherData)
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            return Weather(id: id, name: name, temp: temp)
        } catch {
            delegate?.didFailWithError(self, error)
            return nil
        }
    }
}
