
import SwiftUI

struct DashboardView: View {
    @State private var timePeriod: DashboardTimePeriods = .all
    @ObservedObject var storageManager: StorageManager = .shared
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Dashboard")
                .font(.inter(18.flexible(), weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 40.flexible())
                .padding(.horizontal, 24.flexible())
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12.flexible()) {
                    EnumSelectorRow(selectedType: $timePeriod, padding: 24)
                    
                    HStack(spacing: 8.flexible()) {
                        getCellView(title: "Total Flights", value: "\(flights.count)")
                        getCellView(title: "Flight Hours", value: flightHoursCalculator)
                    }
                    .padding(.horizontal, 24.flexible())
                    
                    expenses
                        .padding(.horizontal, 24.flexible())
                    
                    ChartView(fuel: fuel, service: service, tax: tax, other: other)
                        .padding(.horizontal, 24.flexible())
                    
                    servicePlan
                        .padding(.horizontal, 24.flexible())
                }
            }
        }
        .padding(.vertical, 9.flexible())
    }
    
    var fuel: Int {
        let fuelFinances = finances.filter { $0.category == CategoryModel.fuel.rawValue }
        return fuelFinances.reduce(0) { $0 + Int($1.amount) }
    }
    
    var tax: Int {
        let taxFinances = finances.filter { $0.category == CategoryModel.tax.rawValue }
        return taxFinances.reduce(0) { $0 + Int($1.amount) }
    }
    
    var service: Int {
        let serviceFinances = finances.filter { $0.category == CategoryModel.service.rawValue }
        return serviceFinances.reduce(0) { $0 + Int($1.amount) }
    }
    
    var other: Int {
        let otherFinances = finances.filter { $0.category == CategoryModel.other.rawValue }
        return otherFinances.reduce(0) { $0 + Int($1.amount) }
    }
    
    
    var flights: [FlightEntity] {
        let now = Date()
        let calendar = Calendar.current
        switch timePeriod {
        case .all:
            return storageManager.savedFlights
        case .week:
            if let lastWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: now) {
                return storageManager.savedFlights.filter { flight in
                    guard let flightDate = flight.date else { return false }
                    return flightDate >= lastWeek && flightDate <= now
                }
            }
        case .month:
            if let lastMonth = calendar.date(byAdding: .month, value: -1, to: now) {
                return storageManager.savedFlights.filter { flight in
                    guard let flightDate = flight.date else { return false }
                    return flightDate >= lastMonth && flightDate <= now
                }
            }
        case .halfYear:
            if let lastHalfYear = calendar.date(byAdding: .month, value: -6, to: now) {
                return storageManager.savedFlights.filter { flight in
                    guard let flightDate = flight.date else { return false }
                    return flightDate >= lastHalfYear && flightDate <= now
                }
            }
        case .year:
            if let lastYear = calendar.date(byAdding: .year, value: -1, to: now) {
                return storageManager.savedFlights.filter { flight in
                    guard let flightDate = flight.date else { return false }
                    return flightDate >= lastYear && flightDate <= now
                }
            }
        }
        return []
    }
    
    var finances: [FinanceEntity] {
        let now = Date()
        let calendar = Calendar.current
        
        switch timePeriod {
        case .all:
            return storageManager.savedFinances
            
        case .week:
            if let lastWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: now) {
                return storageManager.savedFinances.filter { finance in
                    guard let financeDate = finance.date else { return false }
                    return financeDate >= lastWeek && financeDate <= now
                }
            }
            
        case .month:
            if let lastMonth = calendar.date(byAdding: .month, value: -1, to: now) {
                return storageManager.savedFinances.filter { finance in
                    guard let financeDate = finance.date else { return false }
                    return financeDate >= lastMonth && financeDate <= now
                }
            }
            
        case .halfYear:
            if let lastHalfYear = calendar.date(byAdding: .month, value: -6, to: now) {
                return storageManager.savedFinances.filter { finance in
                    guard let financeDate = finance.date else { return false }
                    return financeDate >= lastHalfYear && financeDate <= now
                }
            }
            
        case .year:
            if let lastYear = calendar.date(byAdding: .year, value: -1, to: now) {
                return storageManager.savedFinances.filter { finance in
                    guard let financeDate = finance.date else { return false }
                    return financeDate >= lastYear && financeDate <= now
                }
            }
        }
        
        return []
    }
    
    var flightHoursCalculator: String {
        let times = flights.map { ($0.takeoffTime ?? Date()).timeDifferenceInMinutes(to: ($0.boardingTime ?? Date())) }
        let sumOfMinutes = times.reduce(0, +)
        let hours = sumOfMinutes / 60
        let minutes = sumOfMinutes % 60
        return "\(hours)h \(minutes)min"
    }
}

extension DashboardView {
    private var expenses: some View {
        HStack {
            let expences = finances.reduce(0) { $0 + Int($1.amount) }
            Text("$\(expences)")
                .font(.inter(26.flexible(), weight: .black))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Total Expenses")
                .font(.inter(12.flexible(), weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .opacity(0.52)
        }
        .padding(.horizontal, 20.flexible())
        .padding(.vertical, 16.flexible())
        .background(Color.appGray)
        .cornerRadius(16.flexible())
    }
    
    private var servicePlan: some View {
        VStack(spacing: 4.flexible()) {
            Text("Service plan")
                .font(.inter(18.flexible(), weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8.flexible())
            
            let filteredServices = storageManager.savedServices.filter {
                $0.date ?? Date() > Date() || !$0.isOneTime
            }
            
            if filteredServices.isEmpty {
                emptyView
            } else {
                ForEach(filteredServices, id: \.self) { service in
                    ServiceRowView(service: service)
                }
            }
        }
    }
}

extension DashboardView {
    private func getCellView(title: String, value: String) -> some View {
        VStack(spacing: 2.flexible()) {
            Text(title)
                .font(.inter(12.flexible(), weight: .medium))
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .opacity(0.52)
            
            Text(value)
                .font(.inter(40.flexible(), weight: .black))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20.flexible())
        .frame(height: 97.flexible())
        .frame(maxWidth: .infinity)
        .background(Color.appGray)
        .cornerRadius(16.flexible())
    }
    
    private var emptyView: some View {
        VStack(spacing: 0) {
            PlusButton(isExtended: true) {
                CreateServiceView()
            }
            .padding(.bottom, 4.flexible())
            
            Text("Add Service")
                .font(.inter(18.flexible(), weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20.flexible())
            
            Text("You haven't added any entries yet.")
                .font(.inter(16.flexible(), weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .opacity(0.52)
        }
    }
}

#Preview {
    DashboardView()
        .appBackground()
}
