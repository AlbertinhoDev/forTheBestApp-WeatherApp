import SwiftUI

protocol RoutingLogic {
    func push<Screen: Hashable>(_ screen: Screen)
    
    func pop()
}

final class Router: ObservableObject {
    @Published var path: NavigationPath
    
    init(
        path: NavigationPath = NavigationPath()
    ) {
        self.path = path
    }
}

extension Router: RoutingLogic {
    func push<Screen: Hashable>(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        guard !path.isEmpty else {
            return
        }
        path.removeLast()
    }
}
