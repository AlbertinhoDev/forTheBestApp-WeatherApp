import Foundation

protocol Networkable {
    func request(endpoint: Endpoint, keyForCache: String) async throws -> Data
}
