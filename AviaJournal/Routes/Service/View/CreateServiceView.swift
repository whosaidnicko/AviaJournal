
import SwiftUI

fileprivate enum FocusedField {
    case title, price
}

struct CreateServiceView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var createServiceVM = CreateServiceViewModel()
    
    @FocusState fileprivate var isFocused: FocusedField?
    
    @State private var isDatePickerShown: Bool = false
    @State private var isNotificationDatePickerShown: Bool = false
    @State private var isNotificationTimePickerShown: Bool = false
    
    var body: some View {
        bodyContent
            .overlay(alignment: .bottom) {
                if isDatePickerShown {
                    CustomDatePickerView(isDatePickerShown: $isDatePickerShown,
                                         selectedDate: $createServiceVM.selectedDate)
                } else if isNotificationDatePickerShown {
                    CustomDatePickerView(isDatePickerShown: $isNotificationDatePickerShown,
                                         selectedDate: $createServiceVM.notificationDate)
                } else if isNotificationTimePickerShown {
                    CustomTimePickerView(isTimePickerShown: $isNotificationTimePickerShown,
                                         selectedTime: $createServiceVM.notificationDate)
                }
            }
            .onDisappear { createServiceVM.clearAllFields() }
    }
    
    var bodyContent: some View {
        VStack(spacing: 24.flexible()){
            LinkHeaderView(title: "SERVICE PLANNING")
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12.flexible()){
                    titleInfo
                        .focused($isFocused, equals: .title)
                    
                    date
                    
                    VStack(spacing: 4.flexible()) {
                        scheduleType
                        
                        serviceToggle
                    }
                    
                    priceInfo
                        .focused($isFocused, equals: .price)
                    
                    notificationToggle
                    notificationDate
                        .disabled(!createServiceVM.isNotificationActive)
                        .opacity(!createServiceVM.isNotificationActive ? 0.6 : 1)
                    
                    MainButton(title: "Save",
                               isDisabled: !createServiceVM.isValid,
                               height: 60.flexible()) {
                        createServiceVM.createService()
                        dismiss()
                    }
                    .padding(.top, 8.flexible())
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
            if isFocused != nil { isFocused = nil }
        }
    }
}


extension CreateServiceView {
    private var titleInfo: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Title")
            
            customTextField($createServiceVM.title.max(30), placeholder: "Title")
        }
    }
    
    private var date: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Date")
            
            cell(text: createServiceVM.selectedDate.formattedDate())
                .onTapGesture {
                    if isFocused != nil { isFocused = nil }
                    isDatePickerShown = true
                }
        }
    }
    
    private var priceInfo: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Price")
            
            HStack(spacing: 10.flexible()) {
                Text("$")
                    .font(.inter(13.flexible(), weight: .medium))
                    .foregroundColor(.white)
                    .opacity(0.52)
                
                TextField("Price", text: $createServiceVM.price.max(10))
                    .font(.inter(15.flexible(), weight: .semibold))
                    .foregroundStyle(Color.white)
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
    
    private var notificationDate: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Date")
            
            HStack(spacing: 4.flexible()) {
                cell(text: createServiceVM.notificationDate.formattedDate())
                    .onTapGesture {
                        if isFocused != nil { isFocused = nil }
                        isNotificationDatePickerShown = true
                    }
                
                cell(text: createServiceVM.notificationDate.formattedTime())
                    .frame(maxWidth: 90.flexible())
                    .onTapGesture {
                        if isFocused != nil { isFocused = nil }
                        isNotificationTimePickerShown = true
                    }
            }
        }
    }
    
    private var scheduleType: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Schedule")
            
            TypePickerRow(selectedType: $createServiceVM.schedule)
                .disabled(createServiceVM.isOneTime)
                .opacity(createServiceVM.isOneTime ? 0.6 : 1)
        }
    }
    
    private var notificationToggle: some View {
        HStack {
            Text("Set a notification")
                .font(.inter(13.flexible(), weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            CustomToggle(isActive: $createServiceVM.isNotificationActive)
        }
    }
    
    private var serviceToggle: some View {
        HStack(spacing: 6.flexible()) {
            CustomToggle(isActive: $createServiceVM.isOneTime)
            
            Text("One-Time Service")
                .font(.inter(13.flexible(), weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


extension CreateServiceView {
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
    CreateServiceView()
}
