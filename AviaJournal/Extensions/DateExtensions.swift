
import Foundation

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func formattedDateAndTime(showTime: Bool = true) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM. yyyy\(showTime ? " HH:mm" : "")"
        return formatter.string(from: self)
    }
    
    func timeDifference(to endDate: Date) -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: self, to: endDate)
        
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        return "\(abs(hours))h \(abs(minutes))m"
    }
    
    func timeDifferenceInMinutes(to endDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.minute], from: self, to: endDate)
        return abs(components.minute ?? 0)
    }
}
