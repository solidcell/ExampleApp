import Foundation
import Swinject

class AppProxy: NSObject {
    private let appContainer: Resolvable
    // TODO why does this need to be `var`?
    var window: Windowable

    init(appContainer: Resolvable, window: Windowable) {
        self.appContainer = appContainer
        self.window = window
    }

    func willFinishLaunchingWithOptions() -> Bool {
        let dashboard = appContainer.resolve(DashboardPresenting.self)
        window.rootViewPresenter = dashboard
        window.makeKeyAndVisible()
        return true
    }

    func didFinishLaunchingWithOptions() -> Bool {
        return true
    }

    func didBecomeActive() {
    }
    
}