
import SwiftUI

class UserSettings: ObservableObject {
    static let shared = UserSettings()
    
    private init() {}
    
    @AppStorage("isOnboardingShown") var isOnboardingShown: Bool = false
}
