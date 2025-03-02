
import SwiftUI

extension Font {
    static func inter(_ size: CGFloat, weight: Weight = .regular) -> Font {
        switch weight {
        case .bold:
            return Font.custom("Inter18pt-Bold", size: size)
        case .black:
            return Font.custom("Inter18pt-Black", size: size)
        case .semibold:
            return Font.custom("Inter18pt-SemiBold", size: size)
        case .light:
            return Font.custom("Inter18pt-Light", size: size)
        case .medium:
            return Font.custom("Inter18pt-Medium", size: size)
        case .thin:
            return Font.custom("Inter18pt-ExtraLight", size: size)
        default:
            return Font.custom("Inter18pt-Regular", size: size)
        }
    }
    
    static func interExtra(_ size: CGFloat) -> Font {
        return Font.custom("Inter18pt-ExtraBold", size: size)
    }
}
