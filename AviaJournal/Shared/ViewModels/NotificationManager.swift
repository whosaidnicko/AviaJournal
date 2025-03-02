
import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    var isPermissionGranted = false
    
    private init() { }
    
    static func isPushNotificationEnabled(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                completion(true)
            default:
                completion(false)
            }
        }
    }
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            self.isPermissionGranted = granted
            if granted {
                print("Permission to notify has been granted")
            } else {
                print("Permission to notify has been denied")
            }
            completion(granted)
        }
    }

    func scheduleNotification(id: UUID, title: String, body: String, date: Date) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("Notification permission is not granted.")
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default

            let calendar = Calendar.current
            let triggerDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully for \(date)")
                }
            }
        }
    }
    
    func printScheduledNotifications() {
        let center = UNUserNotificationCenter.current()

        center.getPendingNotificationRequests { (requests) in
            for request in requests {
                let content = request.content

                print("Notification Identifier: \(request.identifier)")
                print("Title: \(content.title)")
                print("Body: \(content.body)")

                print("---")
            }
        }
    }
}
