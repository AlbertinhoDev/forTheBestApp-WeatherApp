import SwiftUI

enum ChironGoRoundTC: String {
    case bold = "ChironGoRoundTC-Bold"
    case medium = "ChironGoRoundTC-Medium"
    case regular = "ChironGoRoundTC-Regular"
}

extension Font {
    static func customFont(_ font: ChironGoRoundTC, fontSize: CGFloat) -> Font {
        custom(font.rawValue, size: fontSize)
    }
}
