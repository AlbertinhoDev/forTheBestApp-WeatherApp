import CoreLocation

protocol LocationManagerable {
    func requestLocation() async throws -> CLLocationCoordinate2D?
}
