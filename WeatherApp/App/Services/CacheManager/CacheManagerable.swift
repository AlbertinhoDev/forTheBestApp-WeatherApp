import Foundation

protocol CacheManagerable {
    func saveData(_ data: Data, forKey key: String)
    func loadData(forKey key: String) -> Data?
}
