
import SwiftUI

fileprivate enum FocusedState {
    case pilot, flightNumber, departue, arrival, fuel
}

struct CreateFlightView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var createFlightVM = CreateFlightViewModel()
    
    @FocusState fileprivate var isFocused: FocusedState?
    
    @State private var isDatePickerShown: Bool = false
    @State private var isTimePickerShown: Bool = false
    
    @State private var isTakeoffTimePickerShown: Bool = false
    @State private var isBoardingTimePickerShown: Bool = false
    
    var body: some View {
        bodyContent
            .overlay(alignment: .bottom) {
                if isDatePickerShown {
                    CustomDatePickerView(isDatePickerShown: $isDatePickerShown,
                                         selectedDate: $createFlightVM.selectedDate)
                } else if isTimePickerShown {
                    CustomTimePickerView(isTimePickerShown: $isTimePickerShown,
                                         selectedTime: $createFlightVM.selectedDate)
                } else if isTakeoffTimePickerShown {
                    CustomTimePickerView(isTimePickerShown: $isTakeoffTimePickerShown,
                                         selectedTime: $createFlightVM.takeoffTime)
                } else if isBoardingTimePickerShown {
                    CustomTimePickerView(isTimePickerShown: $isBoardingTimePickerShown,
                                         selectedTime: $createFlightVM.boardingTime)
                }
            }
            .onDisappear {
                createFlightVM.clearFields()
            }
    }
    
    var bodyContent: some View {
        VStack(spacing: 24.flexible()){
            LinkHeaderView(title: "New Flight")
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12.flexible()){
                    pilotInfo
                        .focused($isFocused, equals: .pilot)
                    
                    flightNumber
                        .focused($isFocused, equals: .flightNumber)
                    
                    HStack(spacing: 4.flexible()) {
                        departue
                            .focused($isFocused, equals: .departue)
                        
                        arrival
                            .focused($isFocused, equals: .arrival)
                    }
                    
                    date
                    
                    boardingTimes
                    
                    fuel
                        .focused($isFocused, equals: .fuel)
                    
                    MainButton(title: "Add Flight",
                               isDisabled: !createFlightVM.isValid,
                               height: 60.flexible()) {
                        createFlightVM.createFlight()
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

extension CreateFlightView {
    private var pilotInfo: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Pilot")
            
            customTextField($createFlightVM.pilotName.max(30), placeholder: "Pilot name")
        }
    }
    
    private var flightNumber: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Flight Number")
            
            customTextField($createFlightVM.flightNumber.max(10), placeholder: "Flight Number")
        }
    }
    
    private var departue: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Place of departure")
            
            customTextField($createFlightVM.departue.max(18), placeholder: "Departure")
        }
    }
    
    private var arrival: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Place of arrival")
            
            customTextField($createFlightVM.arrival.max(18), placeholder: "Arrival")
        }
    }
    
    private var date: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Date")
            
            HStack(spacing: 4.flexible()) {
                cell(text: createFlightVM.selectedDate.formattedDate())
                    .onTapGesture {
                        if isFocused != nil { isFocused = nil }
                        isDatePickerShown = true
                    }
                
                cell(text: createFlightVM.selectedDate.formattedTime())
                    .frame(maxWidth: 90.flexible())
                    .onTapGesture {
                        if isFocused != nil { isFocused = nil }
                        isTimePickerShown = true
                    }
            }
        }
    }
    
    private var boardingTimes: some View {
        HStack(spacing: 4.flexible()) {
            VStack(spacing: 2.flexible()) {
                cellTitle("Takeoff time")
                cell(text: createFlightVM.takeoffTime.formattedTime(), isCentered: true)
                    .onTapGesture {
                        if isFocused != nil { isFocused = nil }
                        isTakeoffTimePickerShown = true
                    }
            }
            
            VStack(spacing: 2.flexible()) {
                cellTitle("Boarding time")
                cell(text: createFlightVM.boardingTime.formattedTime(), isCentered: true)
                    .onTapGesture {
                        if isFocused != nil { isFocused = nil }
                        isBoardingTimePickerShown = true
                    }
            }
        }
    }
    
    private var fuel: some View {
        VStack(spacing: 2.flexible()) {
            cellTitle("Fuel consumption")
            
            customTextField($createFlightVM.fuel.max(10), placeholder: "Fuel consumption")
                .keyboardType(.numberPad)
                .overlay(alignment: .trailing) {
                    Text("L")
                        .font(.inter(13.flexible(), weight: .medium))
                        .foregroundColor(.white)
                        .opacity(0.52)
                        .padding(.trailing, 20.flexible())
                }
            
        }
    }
}


extension CreateFlightView {
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
    CreateFlightView()
}
