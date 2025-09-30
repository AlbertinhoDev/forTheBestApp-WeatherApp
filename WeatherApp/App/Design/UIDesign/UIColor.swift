import SwiftUI

extension Color {
    enum SplashScreenBackgroundColor {
        static var topLeading: Color {
            return Color(hex: "623D80")
        }
            
        static var bottomTrailing: Color {
            return Color(hex: "D1EBFF")
        }
    }
    
    enum CurrentScreenBackgroundColor {
        static var topLeading: Color {
            return Color(hex: "D1EBFF")
        }
            
        static var bottomTrailing: Color {
            return Color(hex: "623D80")
        }
    }
    
    enum ForecastScreenBackgroundColor {
        static var topLeading: Color {
            return Color(hex: "251E4B")
        }
            
        static var bottomTrailing: Color {
            return Color(hex: "E0C5F4")
        }
    }
    
    enum LostScreenBackgroundColor {
        static var topLeading: Color {
            return Color(hex: "1E1324")
        }
            
        static var bottomTrailing: Color {
            return Color(hex: "623D80")
        }
    }
    
    enum SplashTitle {
        static var primary: Color {
            return Color(hex: "F0F4F8")
        }
    }
    
    enum CurrentTextColor {
        static var greetingAndLocation: Color {
            return Color(hex: "1A3366")
        }
        
        static var tempTextTime: Color {
            return Color(hex: "333333")
        }
        
        static var buttonAndTitle: Color {
            return Color(hex: "FFFFFF")
        }
        
        static var speedDirectionPressure: Color {
            return Color(hex: "D3D3D3")
        }
    }

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
            case 3:
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6:
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8:
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
