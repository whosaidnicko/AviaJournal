
import SwiftUI

struct RootView: View {
    
    @ObservedObject var tabbarVM: TabbarViewModel = .shared
    @ObservedObject var userSettings: UserSettings = .shared
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    switch tabbarVM.selectedTab {
                    case .dashboard:
                        DashboardView()
                    case .finance:
                        FinanceView()
                    case .journal:
                        JournalView()
                    case .service:
                        ServiceView()
                    case .settings:
                        SettingsView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                TabbarView(selectedTab: $tabbarVM.selectedTab)
            }
            .appBackground()
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)
    }
}

#Preview {
    RootView()
}
class AppDelegate: NSObject, UIApplicationDelegate {
    static var asiuqzoptqxbt = UIInterfaceOrientationMask.portrait {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: asiuqzoptqxbt))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if asiuqzoptqxbt == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.asiuqzoptqxbt
    }
}


