import Foundation
import UIKit

extension Int {
    func flexible(_ scale: Double = 1.5) -> CGFloat {
        return Double(self).flexible(scale)
    }
}

extension Double {
    func flexible(_ scale: Double = 1.5) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if UIDevice.isIphone {
            if screenHeight > 800 {
                return CGFloat(self) * (screenHeight / 852)
            } else {
                return CGFloat(self) * (screenHeight / 736)
            }
        } else {
            let isPro = UIScreen.screenWidth / UIScreen.screenHeight > 0.72
            if isPro {
                return CGFloat(self) * scale * (screenHeight / 1194)
            } else {
                return CGFloat(self) * scale * (screenHeight / 1280)
            }
        }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    
    static let screenHeight = UIScreen.main.bounds.size.height
    
    static let screenSize = UIScreen.main.bounds.size
}

extension UIDevice {
    static let isIphone: Bool = UIDevice.current.userInterfaceIdiom == .phone
    static let isSmallIphone: Bool = UIScreen.main.bounds.height <= 680
}
