import SwiftUI

extension Home.LostConnect {
    struct Screen: View {
        @State private var floating = false
        @State private var angle: Double = 0
        
        var body: some View {
            VStack(spacing: 50) {
                Text("📡 We can't find you\n😥")
                    .multilineTextAlignment(.center)
                    .font(.customFont(.bold, fontSize: 30))
                    .foregroundStyle(.white)
                
                Image("WeCantFindYou")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .offset(y: floating ? -50 : 50)
                    .rotationEffect(.degrees(angle))
                    .animation(
                        Animation.easeInOut(duration: 2.0)
                            .repeatForever(autoreverses: true), value: floating)
                    .onAppear {
                        floating.toggle()
                        withAnimation(
                            Animation.linear(duration: 60.0)
                                .repeatForever(autoreverses: false)
                        ){
                            angle = 360
                        }
                    }
            }
            .applyBackground(
                colorTopLeading: Color.LostScreenBackgroundColor.topLeading,
                colorBottomTrailing: Color.LostScreenBackgroundColor.bottomTrailing
            )
        }
    }
}

#Preview {
    Home.LostConnect.Screen()
}
