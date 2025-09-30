import SwiftUI

extension Home.Current {
    class WeatherState: ObservableObject {
        @Published var currentWeatherData: CurrentWeatherData?
        
        init(currentWeatherData: CurrentWeatherData? = nil) {
            self.currentWeatherData = currentWeatherData
        }
    }
    
    struct CurrentWeatherData {
        var location: String
        var text: String
        var temp_c: Double
        var wind_kph: Double
        var wind_dir: String
        var pressure_mb: Double
        var weatherImage: UIImage
        var localtime: String
    }
}
