import Foundation

extension Home.Splash {
    protocol APIServicable {
        func getCurrentData(latitude: String, longitude: String, keyForCache: String) async throws -> Home.Splash.CurrentWeatherResponse.WeatherResponse
        func getForecastData(latitude: String, longitude: String, keyForCache: String) async throws -> Home.Splash.ForecastWeatherResponse.WeatherResponse
        func getCurrentImage(uRLString: String, keyForCache: String) async throws -> Data
    }
}

extension Home.Splash {
    final class APIService {
        private let decoderService: DecoderServicable
        private let networkService: Networkable
        private let cacheManager: CacheManagerable
        
        public init(
            decoderService: DecoderServicable = DecoderService(),
            cacheManager: CacheManagerable = CacheManager()
        ) {
            self.decoderService = decoderService
            self.cacheManager = cacheManager
            networkService = NetworkService(cacheManager: cacheManager)
        }
        
        private func unite(latitude: String, longitude: String) -> String {
            return "\(latitude),\(longitude)"
        }
    }
}

extension Home.Splash.APIService: Home.Splash.APIServicable {
    func getCurrentData(latitude: String, longitude: String, keyForCache: String) async throws -> Home.Splash.CurrentWeatherResponse.WeatherResponse {
        let location = unite(latitude: latitude, longitude: longitude)
        let endpoint = Home.Splash.Endpoint.getCurrentData(apiKey: Constants.apiKey, location: location)
        let data = try await networkService.request(endpoint: endpoint, keyForCache: keyForCache)
        let response: Home.Splash.CurrentWeatherResponse.WeatherResponse = try decoderService.decode(data: data)
        return response
    }
    
    func getCurrentImage(uRLString: String, keyForCache: String) async throws -> Data {
        let endpoint = Home.Splash.Endpoint.getImage(uRLString: uRLString)
        let data = try await networkService.request(endpoint: endpoint, keyForCache: keyForCache)
        return data
    }
    
    func getForecastData(latitude: String, longitude: String, keyForCache: String) async throws -> Home.Splash.ForecastWeatherResponse.WeatherResponse {
        let location = unite(latitude: latitude, longitude: longitude)
        let endpoint = Home.Splash.Endpoint.getForecastData(apiKey: Constants.apiKey, location: location, days: 7)
        let data = try await networkService.request(endpoint: endpoint, keyForCache: keyForCache)
        let response: Home.Splash.ForecastWeatherResponse.WeatherResponse = try decoderService.decode(data: data)
        return response
    }
}
