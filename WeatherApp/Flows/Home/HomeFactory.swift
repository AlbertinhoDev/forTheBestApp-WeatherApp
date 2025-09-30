import SwiftUI

protocol HomeFactorable {
    func makeView(for screen: HomeScreens) -> AnyView
}

class HomeFactory: ObservableObject {
    private let router: Router
    private let splashViewModel: Home.Splash.ViewModel
    private let currentViewModel: Home.Current.ViewModel
    private let forecastViewModel: Home.Forecast.ViewModel
    private let diContainer: Home.DiContainerable
    private let splashState: SplashState
    private let connectState: ConnectState
    @Published var weatherState: Home.Current.WeatherState

    init(
        router: Router,
        diContainer: Home.DiContainerable = Home.DiContainer(),
        splashState: SplashState,
        connectState: ConnectState,
        weatherState: Home.Current.WeatherState = Home.Current.WeatherState()
    ) {
        self.router = router
        self.splashState = splashState
        self.connectState = connectState
        self.diContainer = diContainer
        self.weatherState = weatherState
        
        self.splashViewModel = Home.Splash.ViewModel(
            splashState: splashState,
            connectState: connectState,
            weatherState: weatherState,
            locationManager: diContainer.locationManager,
            apiService: diContainer.apiSplashService,
            cacheManager: diContainer.cacheManager
        )
        
        self.currentViewModel = Home.Current.ViewModel(
            router: router,
            weatherState: weatherState
        )
        
        self.forecastViewModel = Home.Forecast.ViewModel(router: router)
    }
}

extension HomeFactory: HomeFactorable {
    func makeView(for screen: HomeScreens) -> AnyView {
        switch screen {
        case .splash:
            return AnyView(
                Home.Splash.Screen(viewModel: splashViewModel)
            )
        case .current:
            return AnyView(
                Home.Current.Screen(viewModel: currentViewModel)
            )
        case .forecast:
            return AnyView(
                Home.Forecast.Screen(viewModel: forecastViewModel)
            )
        case .lostConnect:
            return AnyView(
                Home.LostConnect.Screen()
            )
        }
    }
}
