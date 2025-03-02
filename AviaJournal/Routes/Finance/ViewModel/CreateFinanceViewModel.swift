
import Foundation

class CreateFinanceViewModel: ObservableObject {
    
    @Published var selectedCategory: CategoryModel = .service
    @Published var selectedFlight: FlightEntity?
    
    @Published var dontLinkWithFlight: Bool = true
    
    @Published var price: String = ""
    @Published var selectedDate: Date = Date()
    
    @Published var notes: String = ""
    
    var isValid: Bool {
        !price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var flights: [FlightEntity] {
        storageManager.savedFlights
    }
    
    let storageManager = StorageManager.shared
    
    func addFinance() {
        guard isValid else { return }
        let amount = Double(price) ?? 0
        storageManager
            .addFinance(
                category: selectedCategory,
                amount: amount,
                date: selectedDate,
                flightID: dontLinkWithFlight ? nil : selectedFlight?.id,
                notes: notes
            )
    }
    
    func clearAllFields() {
        
    }
}
