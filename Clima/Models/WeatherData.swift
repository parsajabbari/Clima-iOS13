struct WeatherData: Decodable, Encodable {
    let name: String
    let main: Main
    let weather: [WeatherPackage]
}

struct Main: Decodable, Encodable {
    let temp: Double
}

struct WeatherPackage: Codable {
    let id: Int
}

