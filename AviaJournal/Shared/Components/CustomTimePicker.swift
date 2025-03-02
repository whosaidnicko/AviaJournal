import SwiftUI

struct CustomTimePickerView: View {
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    @Binding var isTimePickerShown: Bool
    @Binding var selectedTime: Date
    
    var dueToday: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
                .frame(width: screenWidth)
                .background(Color.black.opacity(0.01))
                .onTapGesture { withAnimation { isTimePickerShown = false } }
            
            
            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(.wheel)
                .contentShape(Rectangle())
                .frame(width: 350.flexible(), height: 200.flexible())
                .background(Color.appGray)
                .cornerRadius(20.flexible())
        }
    }
}
