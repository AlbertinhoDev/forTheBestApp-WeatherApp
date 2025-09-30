import SwiftUI

struct AppCoordinator: View {
    @State var currentRootFlow: Flows = .home
    @StateObject private var router: Router
    
    init(
        router: Router = Router()
    ) {
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            view(for: currentRootFlow)
                .navigationDestination(for: Flows.self) { flow in
                    view(for: flow)
                }
        }
    }
    
    @ViewBuilder
    private func view(for flow: Flows) -> some View {
        switch flow {
            case .home:
                HomeCoordinator(router: router)
        }
    }
}
