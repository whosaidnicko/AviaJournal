import SwiftUI

enum TabbarModel: String, Hashable, CaseIterable {
    case dashboard = "Dashboard"
    case journal = "Journal"
    case finance = "Finance"
    case service = "Service"
    case settings = "Settings"
    
    private var iconName: String {
        switch self {
        case .dashboard: return "dashboardIcon"
        case .journal: return "journalIcon"
        case .finance: return "financeIcon"
        case .service: return "serviceIcon"
        case .settings: return "settingsIcon"
        }
    }
    
    func getIcon(isActive: Bool) -> some View {
        Image(iconName)
            .resizable()
            .scaledToFit()
            .frame(width: 36.flexible(), height: 36.flexible())
            .opacity(isActive ? 1 : 0.5)
    }
}

#Preview {
    TabbarModel.journal.getIcon(isActive: false)
}
