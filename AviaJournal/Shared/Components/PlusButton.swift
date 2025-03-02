
import SwiftUI

struct PlusButton<Content: View>: View {
    
    let destination: (() -> Content)?
    var isExtended: Bool = false
    
    @State private var isLinkOpen: Bool = false
    
    init(isExtended: Bool = false, destination: @escaping () -> Content) {
        self.destination = destination
        self.isExtended = isExtended
    }
    
    init(isExtended: Bool = false) where Content == EmptyView {
        self.destination = nil
        self.isExtended = isExtended
    }
    
    var body: some View {
        if let destination = destination {
            Button(action: {
                isLinkOpen = true
            }, label: { if isExtended { extendedButtonImage } else { buttonImage } })
            .navigationDestination(isPresented: $isLinkOpen) {
                destination()
                    .navigationBarBackButtonHidden(true)
            }
        } else {
            if isExtended { extendedButtonImage } else { buttonImage }
        }
    }
    
    private var buttonImage: some View {
        Image(.plusButton)
            .resizable()
            .scaledToFit()
            .frame(width: 40.flexible(), height: 40.flexible())
    }
    
    private var extendedButtonImage: some View {
        Image(.plusExtended)
            .resizable()
            .scaledToFit()
            .frame(width: 120.flexible(), height: 120.flexible())
    }
}

#Preview {
    PlusButton()
}
