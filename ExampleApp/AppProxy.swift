import Foundation
import Swinject

/***********************
 This the top level object of the shared object graph

 It is created by either the AppDelegate or the tests.
***********************/

class AppProxy: NSObject {
    private let appContainer: Resolvable
    var window: UIWindow

    init(appContainer: Resolvable, screen: Screenable) {
        self.appContainer = appContainer
        self.window = UIWindow(frame: screen.bounds)
    }

    func willFinishLaunchingWithOptions() -> Bool {
        let dashboard = appContainer.resolve(DashboardViewController.self)
        window.rootViewController = dashboard
        window.makeKeyAndVisible()
        return true
    }

    func didFinishLaunchingWithOptions() -> Bool {
        return true
    }

    func didBecomeActive() {
    }
}