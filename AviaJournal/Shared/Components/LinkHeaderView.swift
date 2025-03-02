
import SwiftUI

struct LinkHeaderView: View {
    @Environment(\.dismiss) var dismiss
    
    let title: String
    
    var body: some View {
        HStack(spacing: 8.flexible()) {
            Button(action: { dismiss() }) {
                Image(.backButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20.flexible(), height: 20.flexible())
            }
            
            Text(title)
                .font(.inter(18.flexible(), weight: .bold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 9.flexible())
    }
}

#Preview {
    LinkHeaderView(title: "New Flight")
}
