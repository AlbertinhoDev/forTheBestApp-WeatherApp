extension Home.Splash {
    enum CurrentWeatherResponse {
        struct WeatherResponse: Decodable {
            let location: Location
            let current: CurrentWeather
        }
        
        struct Location: Decodable {
            let name: String
            let country: String
            let lat: Double
            let lon: Double
            let localtime: String

        }
        
        struct CurrentWeather: Decodable {
            let temp_c: Double
            let condition: WeatherCondition
            let wind_kph: Double
            let wind_dir: String
            let pressure_mb: Double
        }
        
        struct WeatherCondition: Decodable {
            let text: String
            let icon: String
        }
    }
}


