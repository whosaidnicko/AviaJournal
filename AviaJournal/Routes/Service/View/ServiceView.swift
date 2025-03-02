
import SwiftUI

struct ServiceView: View {
    
    @State private var isCreateLinkOpen: Bool = false
    @StateObject var storageManager = StorageManager.shared
    
    @State var serviceType: ServiceType = .planned
    
    var services: [ServiceEntity] {
        switch serviceType {
        case .planned:
            storageManager.savedServices.filter {
                !$0.isOneTime || $0.date ?? Date() > Date()
            }
        case .archive:
            storageManager.savedServices.filter {
                $0.isOneTime && $0.date ?? Date() <= Date()
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            EnumSelectorRow(selectedType: $serviceType)
                .scrollDisabled(true)
            
            if services.isEmpty {
                emptyView
                    .padding(.vertical, 40.flexible())
                    .frame(maxHeight: .infinity, alignment: .top)
            } else {                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 4.flexible()) {
                        ForEach(services, id: \.self) { service in
                            ServiceRowView(service: service)
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

extension ServiceView {
    private var header: some View {
        HStack {
            Text("SERVICE PLAN")
                .font(.inter(18.flexible(), weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            PlusButton {
                CreateServiceView()
            }
        }
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
    ServiceView()
        .appBackground()
}
