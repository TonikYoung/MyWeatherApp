import SwiftUI
import Foundation

func getBackgroundColor(code: Int) -> Color {
    var backgroundColor = Color("BaseViewColor")
    switch code {
    case 1000, 1003:
        backgroundColor = Color("SunnyViewColor")
    default:
        break
    }
    return backgroundColor
}
