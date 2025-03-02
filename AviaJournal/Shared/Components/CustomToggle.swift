
import SwiftUI

struct CustomToggle: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.default) {
                isActive.toggle()
            }
        }) {
            ZStack(alignment: isActive ? .trailing : .leading) {
                Capsule()
                    .frame(width: 28.flexible(), height: 16.flexible())
                    .foregroundStyle(Color.darkGray)
                
                Circle()
                    .frame(width: 16.flexible(), height: 16.flexible())
                    .foregroundStyle(isActive ? Color.appRed : Color(hex: 0x747474))
            }
        }
    }
}

#Preview {
    CustomToggle(isActive: .constant(false))
    CustomToggle(isActive: .constant(true))
}
