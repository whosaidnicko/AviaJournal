import SwiftUI

enum OnboardingModel {
    case firstPage, secondPage, thirdPage
    
    var titleText: String {
        switch self {
        case .firstPage:
            "Control your flights"
        case .secondPage:
            "Keep financial records"
        case .thirdPage:
            "Plan aircraft maintenance"
        }
    }
    
    var descriptionText: String {
        switch self {
        case .firstPage:
            "Add detailed flight information and track statistics"
        case .secondPage:
            "Track all expenses and optimize them"
        case .thirdPage:
            "Create a schedule of services and maintenance with notifications"
        }
    }
    
    var buttonText: String {
        switch self {
        case .firstPage:
            "Continue"
        case .secondPage:
            "Next"
        case .thirdPage:
            "Start"
        }
    }
    
    var image: Image {
        switch self {
        case .firstPage:
            Image(.firstPage)
        case .secondPage:
            Image(.secondPage)
        case .thirdPage:
            Image(.thirdPage)
        }
    }
}
