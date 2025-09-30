import Foundation

extension Home.Splash {
    enum Endpoint {
        case getCurrentData(apiKey: String, location: String)
        case getForecastData(apiKey: String, location: String, days: Int)
        case getImage(uRLString: String)
    }
}

extension Home.Splash.Endpoint: Endpoint {
    var scheme: HTTPScheme {
        switch self {
        case .getCurrentData, .getForecastData, .getImage:
            return .https
        }
    }
    
    var host: String {
        switch self {
        case .getCurrentData, .getForecastData:
            return Constants.hostWeather
        case .getImage:
            return ""
        }
    }
    
    var path: String {
        switch self {
        case .getCurrentData:
            return Constants.pathCurrentWeather
        case .getForecastData:
            return Constants.pathForecastWeather
        case .getImage(let uRLString):
            let clearURLString = cleanURLString(uRLString: uRLString)
            return "\(clearURLString)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCurrentData, .getForecastData, .getImage:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getCurrentData(let apiKey, let city):
            return [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "q", value: city)
            ]
        case .getForecastData(let apiKey, let query, let days):
            return [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "days", value: "\(days)")
            ]
        case .getImage:
            return []
        }
    }
    
    private func cleanURLString(uRLString: String) -> String {
        return uRLString.replacingOccurrences(of: "//", with: "")
    }
}
