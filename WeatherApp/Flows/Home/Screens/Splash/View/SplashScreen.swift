import SwiftUI

extension Home.Splash {
    struct Screen: View {
        var viewModel: Home.Splash.ViewModelLogic?
        
        @State private var loadingText: String = ""
        
        var body: some View {
            ZStack {
                VStack  {
                    Text("Weather App")
                        .font(.customFont(.bold, fontSize: 50))
                        .foregroundStyle(Color.SplashTitle.primary)
                        .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)
//                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    Spacer().frame(height: 40)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.SplashTitle.primary))
                        .scaleEffect(2)
                    
                    Spacer().frame(height: 20)
                    
                }
            }
            .applyBackground(colorTopLeading: Color.SplashScreenBackgroundColor.topLeading, colorBottomTrailing: Color.SplashScreenBackgroundColor.bottomTrailing)
            .task {
                await viewModel?.getData()
            }
        }
    }
}

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}

#Preview {
    Home.Splash.Screen()
}
