
import SwiftUI

struct JournalRowView: View {
    
    let flight: FlightEntity?
    @State private var isDetailedSheetOpen: Bool = false
    
    var body: some View {
        Button(action: { isDetailedSheetOpen = true }, label: {
            bodyContent
        })
        .sheet(isPresented: $isDetailedSheetOpen, content: {
            JournalDetailedSheet(flight: flight)
        })
    }
    
    var bodyContent: some View {
        VStack(spacing: 12.flexible()) {
            flightInfo
            
            HStack(spacing: 4.flexible()) {
                userInfoRow
                .frame(maxWidth: .infinity, alignment: .leading)
                
                timeRow
            }
        }
        .padding(.horizontal, 20.flexible())
        .padding(.vertical, 16.flexible())
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appGray)
        .cornerRadius(16.flexible())
    }
    
    private var userInfoRow: some View {
        HStack(spacing: 4.flexible()) {
            Image(.passportIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 18.flexible(), height: 18.flexible())
            
            Text(flight?.pilot ?? "Unknown pilot")
                .font(.inter(14.flexible(), weight: .medium))
                .foregroundColor(.white)
        }
    }
    
    private var timeRow: some View {
        HStack(spacing: 4.flexible()) {
            Image(.clockIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 18.flexible(), height: 18.flexible())
            
            Text((flight?.takeoffTime ?? Date()).timeDifference(to: (flight?.boardingTime ?? Date())))
                .font(.inter(14.flexible(), weight: .medium))
                .foregroundColor(.white)
        }
    }
    
    private var flightInfo: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2.flexible()) {
                Text("\(flight?.departue ?? "-") - \(flight?.arrival ?? "-")")
                    .font(.inter(12.flexible(), weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                Text("\((flight?.date ?? Date()).formattedDateAndTime())")
                    .font(.inter(12.flexible(), weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .opacity(0.52)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(flight?.flightNumber ?? "-")")
                .font(.inter(20.flexible(), weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    JournalRowView(flight: nil)
}
