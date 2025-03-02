
import CoreData

extension StorageManager {
    func findServiceById(id: UUID?) -> ServiceEntity? {
        guard let id else { return nil }
        return savedServices.first(where: { $0.id == id })
    }
}
    
extension StorageManager {
    func fetchServices() {
        let request = NSFetchRequest<ServiceEntity>(entityName: "ServiceEntity")
        
        do {
            savedServices = try container.viewContext.fetch(request)
        } catch {
            debugPrint("Error fetching. \(error)")
        }
    }
    
    func saveServicesData() {
        do {
            try container.viewContext.save()
            fetchServices()
        } catch let error {
            debugPrint("Error \(error).")
        }
    }
    
    func addService(
        id: UUID? = nil,
        date: Date,
        isOneTime: Bool,
        notificationDate: Date?,
        price: Double,
        schedule: String,
        title: String
    ) {
        let newService = ServiceEntity(context: container.viewContext)
        if let id { newService.id = id }
        else { newService.id = UUID() }
        
        newService.date = date
        newService.isOneTime = isOneTime
        newService.notificationDate = notificationDate
        newService.price = price
        newService.schedule = schedule
        newService.title = title
        
        saveServicesData()
        debugPrint("Created Service with id: \(String(describing: newService.id))")
    }
    
    func deleteService(id: UUID? = nil, entity: ServiceEntity? = nil) {
        if let id, let entity = findServiceById(id: id) {
            container.viewContext.delete(entity)
            debugPrint("Deleted Service with id: \(id)")
        } else if let entity {
            container.viewContext.delete(entity)
            debugPrint("Deleted Service by entity: with id = \(String(describing: id))")
        } else {
            debugPrint("Service was not deleted")
        }
        
        saveServicesData()
    }
}
