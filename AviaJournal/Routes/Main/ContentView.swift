
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var tabbarVM: TabbarViewModel = .shared
    @ObservedObject var userSettings: UserSettings = .shared
    
    var body: some View {
        VStack(spacing: 0) {
            if userSettings.isOnboardingShown {
                RootView()
            } else {
                OnboardingView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
        .adpeiwqozpr()
    }
}

#Preview {
    ContentView()
}
