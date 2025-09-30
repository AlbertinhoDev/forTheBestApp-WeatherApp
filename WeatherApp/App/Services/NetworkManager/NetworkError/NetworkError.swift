import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case badResponse
    case invalidToken(String)
    
    var errorDescription: String? {
        switch self {
        case .badURL: return "Неверный URL"
        case .badResponse: return "Ошибка сервера"
        case .invalidToken(let message): return message
        }
    }
}
