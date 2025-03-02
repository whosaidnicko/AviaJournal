
import SwiftUI

struct LoaderView: View {
    @State private var isRotating: Bool = false
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.inter(26.flexible(), weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
         
            Spacer()
            
            ZStack {
                Image(.loader)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160.flexible(), height: 160.flexible())
                    .rotationEffect(.degrees(isRotating ? 360 : 0))
                
                Image(.plane)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80.flexible(), height: 80.flexible())
            }
            .onAppear {
                withAnimation(.linear(duration: 3)) {
                    isRotating = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isLoading = false
                }
            }
        }
        .padding(.vertical, 80.flexible())
    }
}

#Preview {
    LoaderView(isLoading: .constant(false))
}
