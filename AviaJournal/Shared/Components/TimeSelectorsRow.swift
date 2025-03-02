
import SwiftUI

struct EnumSelectorRow<T: RawRepresentable & CaseIterable>: View where T.RawValue == String {
    @Binding var selectedType: T
    
    var padding: Int = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(T.allCases), id: \.rawValue) { type in
                    Button(action: { selectedType = type }, label: {
                        Text(type.rawValue)
                            .font(.inter(14.flexible(), weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12.flexible())
                            .padding(.vertical, 10.flexible())
                            .frame(height: 37.flexible(), alignment: .leading)
                            .background(Color.appGray)
                            .cornerRadius(8.flexible())
                            .opacity(selectedType == type ? 1 : 0.52)
                    })
                }
            }
            .padding(.horizontal, padding.flexible())
        }
    }
}

#Preview {
    EnumSelectorRow(selectedType: .constant(TimePeriodType.lastWeek))
}
