
import SwiftUI

extension Color {
    
    static let appWhite =  Color.white
    static let appRed =  Color(hex: 0xB20000)
    static let appGray =  Color(hex: 0x333333)
    static let darkGray =  Color(hex: 0x292929)
    
    init(hex: UInt64) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
