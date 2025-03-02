
import CoreData

class StorageManager: ObservableObject {
    static let shared = StorageManager()
    
    let container: NSPersistentContainer
    
    @Published var savedFlights: [FlightEntity] = []
    @Published var savedServices: [ServiceEntity] = []
    @Published var savedFinances: [FinanceEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: "FlightContainer")
        container.loadPersistentStores { description, error in
            if let error {
                debugPrint("Error leading core data. \(error)")
            } else {
                debugPrint("Successfully loaded core data.")
            }
        }
        
        fetchFlights()
        fetchServices()
        fetchFinances()
    }
}
