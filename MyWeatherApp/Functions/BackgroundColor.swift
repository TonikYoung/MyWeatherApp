
import SwiftUI
import Foundation

func getBackgroundColor(code: Int) -> Color {
    var backgroundColor = Color(UIColor(named: "BaseViewColor")!)
    switch code {
    case 1000, 1003:
        backgroundColor = Color(UIColor(named: "SunnyViewColor")!)
        break
    default:
        break
    }
    return backgroundColor
}
