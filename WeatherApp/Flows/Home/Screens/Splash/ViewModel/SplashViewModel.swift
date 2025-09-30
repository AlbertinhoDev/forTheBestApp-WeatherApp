import CoreLocation
import SwiftUI

extension Home.Splash {
    protocol ViewModelLogic {
        func getData() async
    }
}

extension Home.Splash {
    final class ViewModel: ObservableObject {
        private var location: CLLocationCoordinate2D?
        
        private let splashState: SplashState
        private let connectState: ConnectState
        private let weatherState: Home.Current.WeatherState
    
        private let locationManager: LocationManagerable
        private let apiService: Home.Splash.APIServicable
        private let cacheManager: CacheManagerable
        
        init(
            splashState: SplashState,
            connectState: ConnectState,
            weatherState: Home.Current.WeatherState,
            locationManager: LocationManagerable,
            apiService: Home.Splash.APIServicable,
            cacheManager: CacheManagerable
        ) {
            self.splashState = splashState
            self.weatherState = weatherState
            self.connectState = connectState
            self.locationManager = locationManager
            self.apiService = apiService
            self.cacheManager = cacheManager
        }
        
        private func loadWeatherImage(uRLString: String) async -> UIImage? {
            do {
                let imageData = try await apiService.getCurrentImage(uRLString: uRLString, keyForCache: Constants.keyForCacheImageWeather)
                return UIImage(data: imageData)
            } catch {
                print("Ошибка загрузки изображения: \(error)")
                return nil
            }
        }
        
        private func writeWeatherData(
            responseWeather: Home.Splash.CurrentWeatherResponse.WeatherResponse,
            imageWeather: UIImage?
        ) -> Home.Current.CurrentWeatherData {
            let fallbackImage = UIImage(systemName: "questionmark") ?? UIImage()
            
            let currentWeatherData = Home.Current.CurrentWeatherData(
                location: responseWeather.location.name,
                text: responseWeather.current.condition.text,
                temp_c: responseWeather.current.temp_c,
                wind_kph: responseWeather.current.wind_kph,
                wind_dir: responseWeather.current.wind_dir,
                pressure_mb: responseWeather.current.pressure_mb,
                weatherImage: imageWeather ?? fallbackImage,
                localtime: responseWeather.location.localtime
            )
            
            return currentWeatherData
        }
        
        private func getLocation() async {
            do {
                location = try await locationManager.requestLocation()
                
                if let location = location {
                    do {
                        let latitude = String(describing: location.latitude)
                        let longitude = String(describing: location.longitude)
                        let responseWeather = try await apiService.getCurrentData(latitude:latitude, longitude: longitude, keyForCache: Constants.keyForCacheResponseWeather)
                        let uRLString = responseWeather.current.condition.icon
                        let imageWeather = await loadWeatherImage(uRLString: uRLString)
                        
                        try? await Task.sleep(seconds: 3.0)
                        
                        await MainActor.run {
                            
                            self.weatherState.currentWeatherData = writeWeatherData(
                                responseWeather: responseWeather,
                                imageWeather: imageWeather
                            )

                            splashState.showSplash = false
                        }
                    } catch {
                        await MainActor.run {
                            print("Ошибка запроса данных: \(error)")
                            connectState.showInformView = true
                        }
                    }
                }
            } catch {
                print("Ошибка запроса разрешения: \(error.localizedDescription)")
                
                await MainActor.run {
                    connectState.showInformView = true
                }
        
                return
            }
        }
    }
}

extension Home.Splash.ViewModel: Home.Splash.ViewModelLogic {
    func getData() async {
        try? await Task.sleep(seconds: 3.0)
        await getLocation()
    }
}
