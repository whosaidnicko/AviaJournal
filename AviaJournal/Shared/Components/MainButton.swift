
import SwiftUI

struct MainButton: View {
    
    let title: String
    var isBold: Bool = false
    var isDisabled: Bool = false
    var height: CGFloat? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(isBold ? .interExtra(20.flexible()) : .inter(15.flexible(), weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.vertical, 18.flexible())
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .background(Color.appRed)
                .cornerRadius(8.flexible())
        }
        .opacity(isDisabled ? 0.6 : 1)
        .disabled(isDisabled)
    }
}

#Preview {
    MainButton(title: "Some") {}
    MainButton(title: "Some disabled", isDisabled: true) {}
}
