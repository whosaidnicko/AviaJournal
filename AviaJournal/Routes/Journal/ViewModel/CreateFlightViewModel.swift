
import Foundation

class CreateFlightViewModel: ObservableObject {
    @Published var pilotName: String = ""
    @Published var flightNumber: String = ""
    @Published var departue: String = ""
    @Published var arrival: String = ""
    
    @Published var selectedDate: Date = Date()
    
    @Published var takeoffTime: Date = Date()
    @Published var boardingTime: Date = Date()
    
    @Published var fuel: String = ""
    
    let storage = StorageManager.shared
    
    var isValid: Bool {
        !pilotName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !flightNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !departue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !arrival.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !fuel.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func createFlight() {
        guard isValid else { return }
        
        let fuelNumber: Int = Int(fuel) ?? 0
        
        storage
            .addFlight(
                arrival: arrival,
                departue: departue,
                date: selectedDate,
                flightNumber: flightNumber,
                fuelConsumption: fuelNumber,
                pilot: pilotName,
                takeoffTime: takeoffTime,
                boardingTime: boardingTime
            )
        
        debugPrint("Flight created successfully")
    }
    
    func clearFields() {
        self.pilotName = ""
        self.flightNumber = ""
        self.departue = ""
        self.arrival = ""
        self.selectedDate = Date()
        self.takeoffTime = Date()
        self.boardingTime = Date()
        self.fuel = ""
    }
}
