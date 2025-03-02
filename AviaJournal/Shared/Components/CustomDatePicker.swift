import SwiftUI

struct CustomDatePickerView: View {
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    @Binding var isDatePickerShown: Bool
    @Binding var selectedDate: Date
    
    let startDate = Date()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(width: screenWidth)
                .background(Color.black.opacity(0.01))
                .onTapGesture { withAnimation { isDatePickerShown = false } }
            
            Group {
                DatePicker(selection: $selectedDate, displayedComponents: .date, label:  { EmptyView() } )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
            }
            .frame(width: 350.flexible(), height: 200.flexible())
            .background(Color.appGray)
            .cornerRadius(20.flexible())
        }
    }
}

