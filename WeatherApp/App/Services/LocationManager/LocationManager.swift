import CoreLocation
import SwiftUI

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
    private var continuation: CheckedContinuation<CLLocationCoordinate2D?, Error>?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
            currentLocation = nil
            continuation?.resume(returning: nil)
            continuation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            currentLocation = newLocation.coordinate
            manager.stopUpdatingLocation()
            continuation?.resume(returning: currentLocation)
            continuation = nil
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка получения местоположения: \(error.localizedDescription)")
        currentLocation = nil
        continuation?.resume(throwing: error)
        continuation = nil
        return
    }
}

extension LocationManager: LocationManagerable {
    func requestLocation() async throws -> CLLocationCoordinate2D? {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            
            let authorizationStatus = locationManager.authorizationStatus
            
            switch authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            default:
                continuation.resume(returning: nil)
            }
        }
    }
}
