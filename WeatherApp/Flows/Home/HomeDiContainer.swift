import Foundation

extension Home {
    protocol DiContainerable {
        var apiSplashService: Home.Splash.APIServicable { get }
        var locationManager: LocationManagerable {get}
        var cacheManager: CacheManagerable {get}
        var decoderService: DecoderServicable {get}
    }
}

extension Home {
    final class DiContainer: Home.DiContainerable {
        var apiSplashService: Home.Splash.APIServicable
        var locationManager: LocationManagerable
        var cacheManager: CacheManagerable
        var decoderService: DecoderServicable
        
        init(
            apiSplashService: Home.Splash.APIServicable = Home.Splash.APIService(),
            locationManager: LocationManagerable = LocationManager(),
            cacheManager: CacheManagerable = CacheManager(),
            decoderService: DecoderServicable = DecoderService()
        ) {
            self.apiSplashService = apiSplashService
            self.locationManager = locationManager
            self.cacheManager = cacheManager
            self.decoderService = decoderService
        }
    }
}
