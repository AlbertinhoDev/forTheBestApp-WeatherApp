import SwiftUI

extension Home.Forecast {
    protocol ViewModelLogic {
        func goToBack()
    }
}

extension Home.Forecast {
    final class ViewModel: ObservableObject {
        private let router: Router
        
        init(router: Router) {
            self.router = router
        }
    }
}

extension Home.Forecast.ViewModel: Home.Forecast.ViewModelLogic {
    func goToBack() {
        router.pop()
    }
}
