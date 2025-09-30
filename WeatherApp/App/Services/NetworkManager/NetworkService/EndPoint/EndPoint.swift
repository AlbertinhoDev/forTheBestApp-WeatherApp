import Foundation

protocol Endpoint {
    var scheme: HTTPScheme { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}
	
