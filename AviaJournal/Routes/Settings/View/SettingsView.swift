
import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @State private var isPrivacyShown: Bool = false
    @State private var isTermsShown: Bool = false
    
    var body: some View {
        bodyContent
            .navigationDestination(isPresented: $isPrivacyShown) {
                PrivacyPolicyView()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $isTermsShown) {
                TermsOfUseView()
                    .navigationBarBackButtonHidden()
            }
    }
    
    var bodyContent: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 12.flexible()) {
                Text("Settings")
                    .font(.inter(18.flexible(), weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 40.flexible())
                
                VStack(spacing: 4.flexible()) {
                    HStack(spacing: 4.flexible()) {
                        Button(action: { isPrivacyShown = true }, label: {
                            getSettingsCell(title: "Privacy Policy", image: .shieldIcon)
                        })
                        
                        
                    }
                    
                    HStack(spacing: 4.flexible()) {
                        Button(action: {
                            if let url = URL(string: AppConstants.shareLink) {
                                DispatchQueue.main.async { share(items: [url]) }
                            }
                        }, label: {
                            getSettingsCell(title: "Share this App", image: .shareIcon)
                        })
                        
                        Button(action: {
                            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                SKStoreReviewController.requestReview(in: scene)
                            }
                        }, label: {
                            getSettingsCell(title: "Rate this App", image: .handIcon)
                        })
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .padding(.horizontal, 24.flexible())
            
            Image(.settings)
                .resizable()
                .scaledToFit()
                .frame(width: 320.flexible(), height: 320.flexible())
        }
    }
}

extension SettingsView {
    private func getSettingsCell(title: String, image: ImageResource) -> some View {
        VStack(spacing: 12.flexible()) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 44.flexible(), height: 44.flexible())
            
            Text(title)
                .font(.inter(17.flexible(), weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20.flexible())
        .padding(.vertical, 32.flexible())
        .frame(maxWidth: .infinity)
        .background(Color.appGray)
        .cornerRadius(16.flexible())
    }
}

#Preview {
    SettingsView()
}
