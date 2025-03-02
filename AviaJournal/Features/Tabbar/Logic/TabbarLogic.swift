

import Foundation

class TabbarViewModel: ObservableObject {
    static let shared = TabbarViewModel()
    
    @Published var selectedTab: TabbarModel = .dashboard
    @Published var isTabbarVisible = true
    
    private init() {}
}
