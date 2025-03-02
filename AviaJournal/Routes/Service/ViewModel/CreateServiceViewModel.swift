
import Foundation

class CreateServiceViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var selectedDate: Date = Date()
    @Published var isNotificationActive: Bool = false {
        didSet {
            notificationManager.requestPermission { _ in }
        }
    }
    @Published var schedule: ScheduleType = .monthly
    @Published var isOneTime: Bool = false
    @Published var notificationDate: Date = Date()
    @Published var price: String = ""
    
    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    let storageManager = StorageManager.shared
    let notificationManager = NotificationManager.shared
    
    func createService() {
        guard isValid else { return }
        
        let priceNumber = Double(price) ?? 0
        
        if isNotificationActive {
            notificationManager
                .scheduleNotification(id: UUID(),
                                      title: title,
                                      body: "Service with price \(price)", date: notificationDate)
        }
        
        storageManager
            .addService(
                date: selectedDate,
                isOneTime: isOneTime,
                notificationDate: isNotificationActive ? notificationDate : nil,
                price: priceNumber,
                schedule: schedule.rawValue,
                title: title
            )
    }
    
    func clearAllFields() {
        self.title = ""
        self.selectedDate = Date()
        self.isNotificationActive = false
        self.schedule = .monthly
        self.isOneTime = false
        self.notificationDate = Date()
        self.price = ""
    }
}
