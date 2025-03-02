
import SwiftUI

struct FlightPickerRow: View {
    let flights: [FlightEntity]
    @Binding var selectedFlight: FlightEntity?
    
    var body: some View {
        VStack {
            Menu {
                ForEach(flights, id: \.self) { flight in
                    Button(action: {
                        selectedFlight = flight
                    }) {
                        Text(flight.flightNumber ?? "-")
                    }
                }
            } label: {
                HStack {
                    Text(selectedFlight?.flightNumber ?? "-")
                        .font(.inter(15.flexible(), weight: .semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(.triangleIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14.flexible(), height: 14.flexible())
                }
                .padding(.vertical, 17.flexible())
                .padding(.horizontal, 20.flexible())
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.darkGray)
                .cornerRadius(8.flexible())
            }
        }
    }
}
