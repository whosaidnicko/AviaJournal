
import Foundation
import CoreData

extension StorageManager {
    func findFlightById(id: UUID?) -> FlightEntity? {
        guard let id else { return nil }
        return savedFlights.first(where: { $0.id == id })
    }
}
    
extension StorageManager {
    func fetchFlights() {
        let request = NSFetchRequest<FlightEntity>(entityName: "FlightEntity")
        
        do {
            savedFlights = try container.viewContext.fetch(request)
        } catch {
            debugPrint("Error fetching. \(error)")
        }
    }
    
    func saveFlightsData() {
        do {
            try container.viewContext.save()
            fetchFlights()
        } catch let error {
            debugPrint("Error \(error).")
        }
    }
    
    func addFlight(
        id: UUID? = nil,
        arrival: String,
        departue: String,
        date: Date,
        flightNumber: String,
        fuelConsumption: Int,
        pilot: String,
        takeoffTime: Date,
        boardingTime: Date
    ) {
        let newFlight = FlightEntity(context: container.viewContext)
        if let id { newFlight.id = id }
        else { newFlight.id = UUID() }
        
        newFlight.arrival = arrival
        newFlight.departue = departue
        newFlight.date = date
        newFlight.flightNumber = flightNumber
        newFlight.fuelConsumption = Int16(fuelConsumption)
        newFlight.pilot = pilot
        newFlight.takeoffTime = takeoffTime
        newFlight.boardingTime = boardingTime
        
        saveFlightsData()
        debugPrint("Created Flight with id: \(String(describing: newFlight.id))")
    }
    
    func updateFlight(
        id: UUID?,
        arrival: String? = nil,
        departue: String? = nil,
        date: Date? = nil,
        flightNumber: String? = nil,
        fuelConsumption: Int? = nil,
        pilot: String? = nil,
        takeoffTime: Date? = nil,
        boardingTime: Date? = nil
    ) {
        guard let id, let entity = findFlightById(id: id) else { return }
        
        if let arrival { entity.arrival = arrival }
        if let departue { entity.departue = departue }
        if let date { entity.date = date }
        if let flightNumber { entity.flightNumber = flightNumber }
        if let fuelConsumption { entity.fuelConsumption = Int16(fuelConsumption) }
        if let pilot { entity.pilot = pilot }
        if let takeoffTime { entity.takeoffTime = takeoffTime }
        if let boardingTime { entity.boardingTime = boardingTime }
        
        saveFlightsData()
        debugPrint("Updated Flight with id: \(id)")
    }
    
    func deleteFlight(id: UUID? = nil, entity: FlightEntity? = nil) {
        if let id, let entity = findFlightById(id: id) {
            container.viewContext.delete(entity)
            debugPrint("Deleted Flight with id: \(id)")
        } else if let entity {
            container.viewContext.delete(entity)
            debugPrint("Deleted Flight by entity: with id = \(String(describing: id))")
        } else {
            debugPrint("Flight was not deleted")
        }
        
        saveFlightsData()
    }
}

