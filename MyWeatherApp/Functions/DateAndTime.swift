
import SwiftUI
import Foundation

// сделать перевод на русский, самое простое попробовать через switch case
func getShortDate(epoch: Int) -> String {
    
    let normalDate = Date(timeIntervalSince1970: TimeInterval(epoch)).formatted(Date.FormatStyle().weekday(.abbreviated))
    var traslatedShordDate = ""
    switch normalDate {
    case "Fri":
        traslatedShordDate = "ПТ"
        break
    case "Mon":
        traslatedShordDate = "ПН"
        break
    case "Tue":
        traslatedShordDate = "ВТ"
        break
    case "Wed":
        traslatedShordDate = "СР"
        break
    case "Thu":
        traslatedShordDate = "ЧТ"
        break
    case "Sat":
        traslatedShordDate = "СБ"
        break
    case "Sun":
        traslatedShordDate = "ВС"
        break
    default:
        break
    }

    return traslatedShordDate
}


func getShortTime(time: String) -> String {

    let shortTime = time.suffix(5)
    
    return "\(shortTime)"
}

func getTranslatedDate(date: String) -> String {
    var correctedDate = ""
    if date.contains("Friday") {
        correctedDate = "Пятница"
    } else if date.contains("Monday") {
        correctedDate = "Понедельник"
    } else if date.contains("Tuesday") {
        correctedDate = "Вторник"
    } else if date.contains("Wednesday") {
        correctedDate = "Среда"
    } else if date.contains("Thursday") {
        correctedDate = "Четверг"
    } else if date.contains("Saturday") {
        correctedDate = "Суббота"
    } else if date.contains("Sunday") {
        correctedDate = "Воскресенье"
    }

    
    return correctedDate
}
