
import SwiftUI

struct FinanceView: View {
    
    @State private var isCreateLinkOpen: Bool = false
    @StateObject var storageManager = StorageManager.shared
    @State private var categoryType: CategoryModel = .fuel
    
    var finances: [FinanceEntity] {
        switch categoryType {
        case .all:
            storageManager.savedFinances
        case .fuel:
            storageManager.savedFinances.filter { $0.category == CategoryModel.fuel.rawValue }
        case .service:
            storageManager.savedFinances.filter { $0.category == CategoryModel.service.rawValue }
        case .tax:
            storageManager.savedFinances.filter { $0.category == CategoryModel.tax.rawValue }
        case .other:
            storageManager.savedFinances.filter { $0.category == CategoryModel.other.rawValue }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            EnumSelectorRow(selectedType: $categoryType)
                .padding(.vertical, 8)
            
            if finances.isEmpty {
                emptyView
                    .padding(.vertical, 40.flexible())
                    .frame(maxHeight: .infinity, alignment: .top)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 4.flexible()) {
                        ForEach(finances, id: \.self) { finance in
                            FinanceRowView(finance: finance)
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

extension FinanceView {
    private var header: some View {
        HStack {
            Text("FINANCE")
                .font(.inter(18.flexible(), weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            PlusButton {
                CreateFinanceView()
            }
        }
    }
    
    private var emptyView: some View {
        VStack(spacing: 0) {
            PlusButton(isExtended: true) {
                CreateFinanceView()
            }
            .padding(.bottom, 4.flexible())
            
            Text("Add Transaction")
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
    FinanceView()
        .appBackground()
}
