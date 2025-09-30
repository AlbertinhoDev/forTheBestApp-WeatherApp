import Foundation

final class NetworkService {
    private var cacheManager: CacheManagerable
    
    init(cacheManager: CacheManagerable) {
        self.cacheManager = cacheManager
    }
}

extension NetworkService: Networkable {
    func request(endpoint: Endpoint, keyForCache: String) async throws -> Data {
        let uRLRequest = try makeURLRequest(endpoint: endpoint)

        let (data, urlResponse) = try await URLSession.shared.data(for: uRLRequest)
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        switch httpURLResponse.statusCode {
        case 200...299:
            cacheManager.saveData(data, forKey: keyForCache)
            return data
        case 401:
            print(httpURLResponse.statusCode)
            break
        default:
            print(httpURLResponse.statusCode)
            throw URLError(.badServerResponse)
        }
        return data
    }
    
    private func makeURLRequest(endpoint: Endpoint) throws -> URLRequest {
        let url = try makeURL(endpoint: endpoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        return urlRequest
    }
    
    private func makeURL(endpoint: Endpoint) throws -> URL {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        
        if endpoint.host != "" {
            components.host = endpoint.host
        }
        
        components.path = endpoint.path
        
        if !endpoint.queryItems.isEmpty {
            components.queryItems = endpoint.queryItems
        }
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        return url
    }
}

