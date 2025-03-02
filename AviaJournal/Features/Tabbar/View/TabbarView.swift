

import SwiftUI

struct TabbarView: View {
    @Binding var selectedTab: TabbarModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabbarModel.allCases, id: \.self) { tabItem in
                Button(action: { withAnimation(.default) { selectedTab = tabItem } },
                       label: {
                    VStack(spacing: 6.flexible()) {
                         tabItem.getIcon(isActive: selectedTab.rawValue == tabItem.rawValue)
                        
                        Text("\(tabItem.rawValue.uppercased())")
                            .font(Font.interExtra(11.flexible()))
                            .foregroundColor(Color.white)
                            .opacity(selectedTab == tabItem ? 1 : 0.5)
                    }
                })
                .frame(maxWidth: .infinity)
            }
        }
        .padding(12.flexible())
        .background(Color.appRed)
        .cornerRadius(20.flexible())
    }
}

#Preview {
    VStack(spacing: 50) {
        TabbarView(selectedTab: .constant(.settings))
    }
}
