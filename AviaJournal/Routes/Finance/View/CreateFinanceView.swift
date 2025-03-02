
import SwiftUI
struct CreateFinanceView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var createFinanceVM = CreateFinanceViewModel()
    
    @FocusState var isFocused: Bool
    
    @State private var isDatePickerShown: Bool = false
    @State private var isTimePickerShown: Bool = false
    
    var body: some View {
        bodyContent
            .overlay(alignment: .bottom) {
                if isDatePickerShown {
                    CustomDatePickerView(isDatePickerShown: $isDatePickerShown,
                                         selectedDate: $createFinanceVM.selectedDate)
                } else if isTimePickerShown {
                    CustomTimePickerView(isTimePickerShown: $isTimePickerShown,
                                         selectedTime: $createFinanceVM.selectedDate)
                }
            }
            .onDisappear { createFinanceVM.clearAllFields() }
    }
    
    var bodyContent: some View {
        VStack(spacing: 24.flexible()){
            LinkHeaderView(title: "Add Transaction")
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12.flexible()){
                    categoryInfo
                    
                    priceInfo
                    
                    date
                    
                    VStack(alignment: .leading, spacing: 4.flexible()) {
                        flightInfo
                            .disabled(createFinanceVM.dontLinkWithFlight)
                            .opacity(createFinanceVM.dontLinkWithFlight ? 0.6 : 1)
                        
                        flightToggle
                    }
                    
                    notes
                    
                    MainButton(title: "Add Transaction", height: 60.flexible()) {
                        createFinanceVM.addFinance()
                        dismiss()
                    }
                    .padding(.vertical, 20.flexible())
                }
                .padding(20.flexible())
                .frame(maxWidth: .infinity)
                .background(Color.appGray)
                .cornerRadius(16.flexible())
            }
        }
        .padding(.horizontal, 24.flexible())
        .appBackground()
        .onTapGesture {
            if isFocused { isFocused = false }
        }
    }
}


extension CreateFinanceView {
    private var categoryInfo: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Category")
            
            TypePickerRow(selectedType: $createFinanceVM.selectedCategory)
        }
    }
    
    private var flightInfo: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Flight")
            
            FlightPickerRow(flights: createFinanceVM.flights,
                            selectedFlight: $createFinanceVM.selectedFlight)
        }
    }
    
    private var flightToggle: some View {
        HStack(spacing: 6.flexible()) {
            CustomToggle(isActive: $createFinanceVM.dontLinkWithFlight)
            
            Text("Do not link to a flight")
                .font(.inter(13.flexible(), weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var priceInfo: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Amount")
            
            HStack(spacing: 10.flexible()) {
                Text("$")
                    .font(.inter(13.flexible(), weight: .medium))
                    .foregroundColor(.white)
                    .opacity(0.52)
                
                TextField("Amount", text: $createFinanceVM.price.max(10))
                    .font(.inter(15.flexible(), weight: .semibold))
                    .foregroundStyle(Color.white)
                    .focused($isFocused)
            }
            .padding(.vertical, 17.flexible())
            .padding(.horizontal, 20.flexible())
            .background(Color.darkGray)
            .cornerRadius(8.flexible())
            .autocorrectionDisabled()
            .tint(.white)
            .keyboardType(.numberPad)
        }
    }
    
    private var date: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Date")
            
            HStack(spacing: 4.flexible()) {
                cell(text: createFinanceVM.selectedDate.formattedDate())
                    .onTapGesture {
                        if isFocused { isFocused = false }
                        isDatePickerShown = true
                    }
                
                cell(text: createFinanceVM.selectedDate.formattedTime())
                    .frame(maxWidth: 90.flexible())
                    .onTapGesture {
                        if isFocused { isFocused = false }
                        isTimePickerShown = true
                    }
            }
        }
    }
    
    private var notes: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Note")
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $createFinanceVM.notes.max(100))
                    .font(.inter(15.flexible(), weight: .semibold))
                    .foregroundStyle(Color.white)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 20.flexible())
                    .padding(.vertical, 17.flexible())
                    .frame(height: 104.flexible())
                    .background(Color.darkGray)
                    .cornerRadius(8.flexible())
                    .autocorrectionDisabled()
                    .tint(.white)
                    .focused($isFocused)
                
                if createFinanceVM.notes.isEmpty && !isFocused {
                    Text("Note")
                        .font(.inter(15.flexible(), weight: .semibold))
                        .foregroundStyle(Color.white.opacity(0.6))
                        .padding(.horizontal, 24.flexible())
                        .padding(.vertical, 21.flexible())
                }
            }
        }
    }
}


extension CreateFinanceView {
    private func cellTitle(_ title: String) -> some View {
        Text(title)
            .font(.inter(12.flexible(), weight: .medium))
            .lineLimit(1)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(0.52)
    }
    
    func cell(text: String, isPlaceholder: Bool = false, isCentered: Bool = false) -> some View {
        Text(text)
            .font(.inter(15.flexible(), weight: .semibold))
            .foregroundStyle(Color.white)
            .padding(.vertical, 17.flexible())
            .padding(.horizontal, 20.flexible())
            .frame(maxWidth: .infinity, alignment: isCentered ? .center : .leading)
            .background(Color.darkGray)
            .cornerRadius(8.flexible())
    }
    
    func customTextField(_ text: Binding<String>, placeholder: String) -> some View {
        TextField(placeholder, text: text)
            .font(.inter(15.flexible(), weight: .semibold))
            .foregroundStyle(Color.white)
            .padding(.vertical, 17.flexible())
            .padding(.horizontal, 20.flexible())
            .background(Color.darkGray)
            .cornerRadius(8.flexible())
            .autocorrectionDisabled()
            .tint(.white)
    }
}

#Preview {
    CreateFinanceView()
}
