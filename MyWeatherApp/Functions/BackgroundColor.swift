import SwiftUI
import Foundation

func getBackgroundColor(code: Int) -> Color {
    var backgroundColor = Color.setColor(colorName: "BaseViewColor")
    switch code {
    case 1000, 1003:
        backgroundColor = Color.setColor(colorName: "SunnyViewColor")
        break
    default:
        break
    }
    return backgroundColor
}

extension Color {
    static func setColor(colorName: String) -> Color {
        if let color = UIColor(named: colorName) {
            Color(uiColor: color)
        } else {
            Color.gray
        }
    }
}
