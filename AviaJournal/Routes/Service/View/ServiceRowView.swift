
import SwiftUI

struct ServiceRowView: View {
    
    let service: ServiceEntity?
    var isPlanned: Bool {
        !(service?.isOneTime ?? true) ||
        (service?.date ?? Date()) > Date()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.flexible()) {
            
            HStack(spacing: 4.flexible()) {
                Text(service?.title ?? "-")
                    .font(.inter(15.flexible(), weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text((service?.date ?? Date()).formattedDateAndTime(showTime: false))
                    .font(.inter(15.flexible(), weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .opacity(0.52)
            }
            
            Text("$\(String(format: "%.2f", service?.price ?? 0))")
                .font(.inter(12.flexible(), weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .opacity(0.52)
            
            if isPlanned {
                HStack {
                    HStack(spacing: 4.flexible()) {
                        Image(.bellIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18.flexible(), height: 18.flexible())
                        
                        Text((service?.date ?? Date()).formattedDateAndTime())
                            .font(.inter(14.flexible(), weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 4.flexible()) {
                        Image(.calendarIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18.flexible(), height: 18.flexible())
                        
                        Text("\(service?.isOneTime ?? true ? "One-time" : "Regularly")")
                            .font(.inter(14.flexible(), weight: .medium))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.horizontal, 20.flexible())
        .padding(.vertical, 16.flexible())
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appGray)
        .cornerRadius(16.flexible())
    }
}

#Preview {
    ServiceRowView(service: nil)
}
