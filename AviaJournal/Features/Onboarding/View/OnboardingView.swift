
import SwiftUI

struct OnboardingView: View {
    @StateObject var onboardingVM: OnboardingViewModel = .init()
    @State private var isLoading: Bool = true
    
    var body: some View {
        Group {
            if isLoading {
                LoaderView(isLoading: $isLoading)
            } else {
                content
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.spring(), value: isLoading)
    }
    
    var content: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(onboardingVM.currentStep.titleText)
                        .font(.inter(26.flexible(), weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 12.flexible())
                    
                    Text(onboardingVM.currentStep.descriptionText)
                        .font(.inter(16.flexible(), weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
                .frame(height: UIDevice.isSmallIphone ? 150 : 200.flexible())
                
                MainButton(title: onboardingVM.currentStep.buttonText, isBold: true) {
                    withAnimation(.default) { onboardingVM.nextStep() }
                }
                .padding(.horizontal, 20.flexible())
            }
            .padding(.vertical, UIDevice.isSmallIphone ? 30 : 60.flexible())
            .padding(.horizontal, 24.flexible())
            .frame(maxHeight: .infinity, alignment: .top)
            
            onboardingVM.currentStep.image
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth)
                .clipped()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    OnboardingView()
}
