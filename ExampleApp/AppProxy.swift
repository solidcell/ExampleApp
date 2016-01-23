import Foundation
import Swinject

/***********************
 This the top level object of the shared object graph

 It is created by either the AppDelegate or the tests.
***********************/

class AppProxy: NSObject {
    private let appContainer: Resolvable
    // TODO why does this need to be `var`?
    var window: Windowable

    init(appContainer: Resolvable, window: Windowable) {
        self.appContainer = appContainer
        self.window = window
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