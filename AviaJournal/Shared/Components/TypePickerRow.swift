
import SwiftUI

struct TypePickerRow<T: RawRepresentable & CaseIterable>: View where T.RawValue == String {
    @Binding var selectedType: T
    
    var body: some View {
        VStack {
            Menu {
                ForEach(Array(T.allCases), id: \.rawValue) { type in
                    if type.rawValue != "All" {                        
                        Button(action: {
                            selectedType = type
                        }) {
                            Text(type.rawValue)
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedType.rawValue)
                        .font(.inter(15.flexible(), weight: .semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(.triangleIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14.flexible(), height: 14.flexible())
                }
                    .padding(.vertical, 17.flexible())
                    .padding(.horizontal, 20.flexible())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.darkGray)
                    .cornerRadius(8.flexible())
            }
        }
    }
}

#Preview {
    TypePickerRow(selectedType: .constant(ScheduleType.monthly))
}
