import SwiftUI

@MainActor
final class OnboardingViewModel: ObservableObject {
    
    @Published var currentStep: OnboardingModel = .firstPage
    
    func nextStep() {
        switch currentStep {
        case .firstPage:
            currentStep = .secondPage
        case .secondPage:
            currentStep = .thirdPage
        case .thirdPage:
            signIn()
        }
    }
    
    func skipAction() {
        currentStep = .thirdPage
    }
    
    func signIn() {
        print("Sign in")
        withAnimation(.default) { UserSettings.shared.isOnboardingShown = true }
    }
}
