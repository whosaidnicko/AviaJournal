
import SwiftUI

struct JournalDetailedSheet: View {
    
    let flight: FlightEntity?
    
    var body: some View {
        sheetBody
            .presentationDetents([.fraction(0.5)])
            .presentationDragIndicator(.visible)
    }
    
    var sheetBody: some View {
        VStack(alignment: .leading, spacing: 12.flexible()) {
            HStack {
                Text("\(flight?.departue ?? "-") - \(flight?.arrival ?? "-")")
                    .font(.inter(20.flexible(), weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(flight?.flightNumber ?? "-")")
                    .font(.inter(20.flexible(), weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
            
            HStack(spacing: 20.flexible()) {
                VStack(alignment: .leading, spacing: 2.flexible()) {
                    cellTitle("Date")
                    Text("\((flight?.date ?? Date()).formattedDateAndTime())")
                }
                
                VStack(alignment: .leading, spacing: 2.flexible()) {
                    cellTitle("Duration")
                    cellValue((flight?.takeoffTime ?? Date()).timeDifference(to: (flight?.boardingTime ?? Date())))
                }
            }
            
            HStack(spacing: 20.flexible()) {
                VStack(alignment: .leading, spacing: 2.flexible()) {
                    cellTitle("Takeoff time")
                    cellValue((flight?.takeoffTime ?? Date()).formattedTime())
                }
                
                VStack(alignment: .leading, spacing: 2.flexible()) {
                    cellTitle("Boarding time")
                    cellValue((flight?.boardingTime ?? Date()).formattedTime())
                }
            }
            
            VStack(alignment: .leading, spacing: 2.flexible()) {
                cellTitle("Fuel consumption")
                cellValue("\(flight?.fuelConsumption ?? 0) l")
            }
            
            let fuelExpense = Double((flight?.fuelConsumption ?? 0)) * 1.1
            let taxExpense = Double((flight?.fuelConsumption ?? 0)) * 20.3
            let serviceExpense = Double((flight?.fuelConsumption ?? 0)) * 25.3
            let otherExpense = Double((flight?.fuelConsumption ?? 0)) * 3
            let totalExpenses = fuelExpense + taxExpense + serviceExpense + otherExpense
            
            VStack(alignment: .leading, spacing: 2.flexible()) {
                cellTitle("Expenses")
                
                let formattedTotalExpenses = String(format: "%.2f", totalExpenses)
                cellValue("$\(formattedTotalExpenses)")
            }

            VStack(alignment: .leading, spacing: 2.flexible()) {
                HStack {
                    cellTitle("Expenses")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    let formattedFuelExpense = String(format: "%.2f", fuelExpense)
                    statisticsValue("$\(formattedFuelExpense)")
                }
                
                HStack {
                    cellTitle("Tax")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    let formattedTaxExpense = String(format: "%.2f", taxExpense)
                    statisticsValue("$\(formattedTaxExpense)")
                }
                
                HStack {
                    cellTitle("Service")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    let formattedServiceExpense = String(format: "%.2f", serviceExpense)
                    statisticsValue("$\(formattedServiceExpense)")
                }
                
                HStack {
                    cellTitle("Other")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    let formattedOtherExpense = String(format: "%.2f", otherExpense)
                    statisticsValue("$\(formattedOtherExpense)")
                }
            }
        }
        .padding(.vertical, 12.flexible())
        .padding(.horizontal, 24.flexible())
    }
}

extension JournalDetailedSheet {
    private func cellTitle(_ title: String) -> some View {
        Text(title)
            .font(.inter(12.flexible(), weight: .medium))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(0.52)
    }
    
    private func cellValue(_ title: String) -> some View {
        Text(title)
            .font(.inter(15.flexible(), weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func statisticsValue(_ title: String) -> some View {
        Text(title)
            .font(.inter(13.flexible(), weight: .semibold))
            .multilineTextAlignment(.trailing)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            JournalDetailedSheet(flight: nil)
        }
}
