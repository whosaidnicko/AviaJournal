
import SwiftUI

struct JournalView: View {
    
    @State private var isCreateLinkOpen: Bool = false
    @StateObject var storageManager = StorageManager.shared
    
    @State private var timePeriod: TimePeriodType = .all
    
    var flights: [FlightEntity] {
        let now = Date()
        let calendar = Calendar.current
        switch timePeriod {
        case .all:
            return storageManager.savedFlights
        case .lastWeek:
            if let lastWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: now) {
                return storageManager.savedFlights.filter { flight in
                    guard let flightDate = flight.date else { return false }
                    return flightDate >= lastWeek && flightDate <= now
                }
            }
        case .lastMonth:
            if let lastMonth = calendar.date(byAdding: .month, value: -1, to: now) {
                return storageManager.savedFlights.filter { flight in
                    guard let flightDate = flight.date else { return false }
                    return flightDate >= lastMonth && flightDate <= now
                }
            }
        case .lastYear:
            if let lastYear = calendar.date(byAdding: .year, value: -1, to: now) {
                return storageManager.savedFlights.filter { flight in
                    guard let flightDate = flight.date else { return false }
                    return flightDate >= lastYear && flightDate <= now
                }
            }
        }
        return []
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            EnumSelectorRow(selectedType: $timePeriod)
                .scrollDisabled(true)
            
            if flights.isEmpty {
                emptyView
                    .padding(.vertical, 40.flexible())
                    .frame(maxHeight: .infinity, alignment: .top)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 4.flexible()) {
                        ForEach(flights, id: \.self) { flight in
                            JournalRowView(flight: flight)
                        }
                    }
                    .padding(.vertical, 8.flexible())
                }
            }
        }
        .padding(.vertical, 12.flexible())
        .padding(.horizontal, 24.flexible())
    }
}

extension JournalView {
    private var header: some View {
        HStack {
            Text("FLIGHT JOURNAL")
                .font(.inter(18.flexible(), weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            PlusButton {
                CreateFlightView()
            }
        }
    }
    
    private var emptyView: some View {
        VStack(spacing: 0) {
            PlusButton(isExtended: true) {
                CreateFlightView()
            }
            .padding(.bottom, 4.flexible())
            
            Text("Add Flight")
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
    JournalView()
}
