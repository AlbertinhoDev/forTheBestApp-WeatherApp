import Foundation

struct Constants {
    static let apiKey = "?" //Api key for rest api
    static let hostWeather = "api.weatherapi.com"
    static let pathCurrentWeather = "/v1/current.json"
    static let pathForecastWeather = "/v1/forecast.json"
    static let keyForCacheResponseWeather = "responseWeatherKey" //key for current weather from cache file manager
    static let keyForCacheImageWeather = "responseImageWeatherKey" //key for current weather's image from cache file manager
}
