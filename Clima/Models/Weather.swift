//
//  Weather.swift
//  Clima
//
//  Created by Parsa Jabbari on 9/21/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct Weather {
    let id: Int
    let name: String
    let temp: Double
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    var condition: String {
        switch id {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "tornado"
        case 800:
            return "sun.min"
        case 801...804:
            return "cloud"
        default:
            return "questionmark.circle"
        }
    }
}
