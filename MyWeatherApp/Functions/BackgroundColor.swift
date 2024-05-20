
import SwiftUI
import Foundation

func getBackgroundColor(code: Int) -> Color {
    var backgroundColor = Color.init(red: 40/255, green: 70/255, blue: 70/255)
    switch code {
    case 1000, 1003:
        backgroundColor = Color.init(red: 0/255, green: 114/255, blue: 160/255)
        break
    default:
        break
    }
    return backgroundColor
}
