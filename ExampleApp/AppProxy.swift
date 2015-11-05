import Foundation

class AppProxy {
    let window: Windowable

    init(window: Windowable) {
        self.window = window
    }

    func willFinishLaunchingWithOptions() {
        window.rootViewController = DashboardViewController()
    }

    func didFinishLaunchingWithOptions() {
    }

    func applicationDidBecomeActive() {
    }
    
}