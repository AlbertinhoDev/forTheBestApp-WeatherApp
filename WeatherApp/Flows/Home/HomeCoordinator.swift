import SwiftUI

struct HomeCoordinator: View {
    @StateObject private var splashState: SplashState
    @StateObject private var connectState: ConnectState
    @StateObject private var homeFactory: HomeFactory
    
    private var startScreen: HomeScreens {
        connectState.showInformView ? .lostConnect : (splashState.showSplash ? .splash : .current)
    }
    private let router: Router
    
    init(
        router: Router,
        homeScreenFactory: HomeFactory? = nil,
        splashState: SplashState = SplashState(),z
        connectState: ConnectState = ConnectState()
    ) {
        self.router = router
        self._splashState = StateObject(wrappedValue: splashState)
        self._connectState = StateObject(wrappedValue: connectState)
        self._homeFactory = StateObject(wrappedValue: homeScreenFactory ?? HomeFactory(router: router, splashState: splashState, connectState: connectState))//
    }
    
    var body: some View {
        homeFactory.makeView(for: startScreen)
            .navigationDestination(for: HomeScreens.self) { screen in
                homeFactory.makeView(for: screen)
            }
    }
}



