import SwiftUI

struct BackgroundModifier: ViewModifier {
    var colorTopLeading: Color
    var colorBottomTrailing: Color
    
    func body(content: Content) -> some View {
        ZStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [colorTopLeading, colorBottomTrailing]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

extension View {
    func applyBackground(colorTopLeading: Color, colorBottomTrailing: Color) -> some View {
        self.modifier(BackgroundModifier(colorTopLeading: colorTopLeading, colorBottomTrailing: colorBottomTrailing))
    }
}
