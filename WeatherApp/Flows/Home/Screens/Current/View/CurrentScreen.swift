import SwiftUI

extension Home.Current {
    struct Screen: View {
        var viewModel: Home.Current.ViewModelLogic
        
        var body: some View {
            VStack {
                VStack(spacing: 30) {
                    HStack() {
                        Text(viewModel.timeOfDay)
                            .font(.customFont(.medium, fontSize: 25))
                            .foregroundStyle(Color.CurrentTextColor.greetingAndLocation)
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        Text(viewModel.location)//Api
                            .font(.customFont(.bold, fontSize: 25))
                            .foregroundStyle(Color.CurrentTextColor.greetingAndLocation)
                        
                        Spacer()
                        
                    }
                    
                    Image(uiImage: viewModel.weatherImage)
                        .frame(width: 140, height: 140)
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(hex: "623D80"), Color(hex: "D1EBFF")]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 4
                                )
                        }
                    
                    Text("\(viewModel.temperature.removeZeros())º C")
                        .font(.customFont(.bold, fontSize: 25))
                        .foregroundStyle(Color.CurrentTextColor.tempTextTime)
                    
                    Text("\(viewModel.text)")//Api
                        .font(.customFont(.medium, fontSize: 25))
                        .foregroundStyle(Color.CurrentTextColor.tempTextTime)
                    
                    Text("\(viewModel.localtime)")
                        .font(.customFont(.medium, fontSize: 25))
                        .foregroundStyle(Color.CurrentTextColor.tempTextTime)
                    
                    Button {
                        viewModel.goToForecast()
                    } label: {
                        Text("Next days")
                            .font(.customFont(.regular, fontSize: 25))
                            .foregroundStyle(Color.CurrentTextColor.buttonAndTitle)
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("Wind speed")
                                    .font(.customFont(.regular, fontSize: 18))
                                    .foregroundStyle(Color.CurrentTextColor.buttonAndTitle)
                                
                                Text("\(viewModel.windSpeed.removeZeros())")
                                    .font(.customFont(.bold, fontSize: 20))
                                    .foregroundStyle(Color.CurrentTextColor.speedDirectionPressure)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Wind direction")
                                    .font(.customFont(.regular, fontSize: 18))
                                    .foregroundStyle(Color.CurrentTextColor.buttonAndTitle)
                                
                                Text("\(viewModel.windDirection)")
                                    .font(.customFont(.bold, fontSize: 20))
                                    .foregroundStyle(Color.CurrentTextColor.speedDirectionPressure)
                            }
                                
                            VStack(alignment: .leading) {
                                Text("Atmospheric pressure")//Api
                                    .font(.customFont(.regular, fontSize: 18))
                                    .foregroundStyle(Color.CurrentTextColor.buttonAndTitle)
                                
                                Text("\(viewModel.pressure.removeZeros())")
                                    .font(.customFont(.bold, fontSize: 20))
                                    .foregroundStyle(Color.CurrentTextColor.speedDirectionPressure)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                }
                .padding(.top, 60)
                .padding(.horizontal, 16)
            }
            .applyBackground(
                colorTopLeading: Color.CurrentScreenBackgroundColor.topLeading,
                colorBottomTrailing: Color.CurrentScreenBackgroundColor.bottomTrailing
            )
            
        }
    }
}

#Preview {
    let weatherState = Home.Current.WeatherState(currentWeatherData: Home.Current.CurrentWeatherData(
        location: "Mars",
        text: "Sunny",
        temp_c: -60.0,
        wind_kph: 200,
        wind_dir: "SW",
        pressure_mb: 10,
        weatherImage: UIImage(),
        localtime: "2025-10-01 23:00"
    ))
    
    Home.Current.Screen(viewModel: Home.Current.ViewModel(router: Router(), weatherState: weatherState))
}
