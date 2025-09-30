import SwiftUI

extension Home.Forecast {
    struct Screen: View {
        var viewModel: Home.Forecast.ViewModelLogic
        
        var body: some View {
            VStack {
                Text("Soon")
            }
            .applyBackground(
                colorTopLeading: Color.ForecastScreenBackgroundColor.topLeading,
                colorBottomTrailing: Color.ForecastScreenBackgroundColor.bottomTrailing
            )
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.goToBack()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                        }
                }
            }
        }
    }
}


#Preview {
    Home.Forecast.Screen(viewModel: Home.Forecast.ViewModel(router: Router()))
}
