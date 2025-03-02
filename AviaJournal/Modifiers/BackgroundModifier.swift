import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                Image(.background)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.1)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                    .clipped()
                    .ignoresSafeArea()
            }
            
    }
}

extension View {
    func appBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}

#Preview(body: {
    Text("")
        .appBackground()
})

