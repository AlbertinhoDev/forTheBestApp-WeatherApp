import SwiftUI

extension Home.Current {
    protocol ViewModelLogic {
        var location: String {get}
        var weatherImage: UIImage {get}
        var temperature: Double {get}
        var windSpeed: Double {get}
        var windDirection: String {get}
        var pressure: Double {get}
        var text: String {get}
        var localtime: String {get}
        var timeOfDay: String {get}
        
        func goToForecast()
    }
}

extension Home.Current {
    final class ViewModel {
        private let router: Router
        private let weatherState: Home.Current.WeatherState
        
        init(
            router: Router,
            weatherState: Home.Current.WeatherState
            
        ) {
            self.router = router
            self.weatherState = weatherState
        }
    }
}

extension Home.Current.ViewModel: Home.Current.ViewModelLogic {
    func goToForecast() {
        router.push(HomeScreens.forecast)
    }
    
    var location: String {
        weatherState.currentWeatherData?.location ?? ""
    }
    
    var weatherImage: UIImage {
        weatherState.currentWeatherData?.weatherImage ?? UIImage()
    }
    
    var temperature: Double {
        weatherState.currentWeatherData?.temp_c ?? 0.0
    }
    
    var localtime: String {
        weatherState.currentWeatherData?.localtime ?? ""
    }
    
    var windSpeed: Double {
        weatherState.currentWeatherData?.wind_kph ?? 0.0
    }
    
    var windDirection: String {
        weatherState.currentWeatherData?.wind_dir ?? ""
    }
    
    var pressure: Double {
        weatherState.currentWeatherData?.pressure_mb ?? 0.0
    }
    
    var text: String {
        weatherState.currentWeatherData?.text ?? ""
    }
    
    var timeOfDay: String {
        guard !localtime.isEmpty else { return "Glad to see you" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = dateFormatter.date(from: localtime) else {
            return "Glad to see you"
        }
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        switch hour {
        case 6..<12:
            return "Good morning!"
        case 12..<18:
            return "Good afternoon!"
        case 18..<23:
            return "Good evening!"
        default:
            return "Good night!"
        }
    }
}
