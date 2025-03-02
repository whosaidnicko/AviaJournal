
import Foundation
import CoreData

extension StorageManager {
    func findFinanceById(id: UUID?) -> FinanceEntity? {
        guard let id else { return nil }
        return savedFinances.first(where: { $0.id == id })
    }
}
    
extension StorageManager {
    func fetchFinances() {
        let request = NSFetchRequest<FinanceEntity>(entityName: "FinanceEntity")
        
        do {
            savedFinances = try container.viewContext.fetch(request)
        } catch {
            debugPrint("Error fetching. \(error)")
        }
    }
    
    func saveFinancesData() {
        do {
            try container.viewContext.save()
            fetchFinances()
        } catch let error {
            debugPrint("Error \(error).")
        }
    }
    
    func addFinance(
        id: UUID? = nil,
        category: CategoryModel,
        amount: Double,
        date: Date,
        flightID: UUID?,
        notes: String
    ) {
        let newFinance = FinanceEntity(context: container.viewContext)
        if let id { newFinance.id = id }
        else { newFinance.id = UUID() }
        
        newFinance.category = category.rawValue
        newFinance.amount = amount
        newFinance.date = date
        newFinance.flightID = flightID
        newFinance.notes = notes
        
        saveFinancesData()
        debugPrint("Created Finance with id: \(String(describing: newFinance.id))")
    }
    
    func deleteFinance(id: UUID? = nil, entity: FinanceEntity? = nil) {
        if let id, let entity = findFinanceById(id: id) {
            container.viewContext.delete(entity)
            debugPrint("Deleted Finance with id: \(id)")
        } else if let entity {
            container.viewContext.delete(entity)
            debugPrint("Deleted Finance by entity: with id = \(String(describing: id))")
        } else {
            debugPrint("Finance was not deleted")
        }
        
        saveFinancesData()
    }
}
