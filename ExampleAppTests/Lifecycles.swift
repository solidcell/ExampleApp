@testable import ExampleApp
import Foundation

/***********************
 These are formalized implementations of life cycles that
 occur external to the object graph:
 
 * iOS sending messages to the AppDelegate (and thus, AppProxy)
 * Lifecycle calls for ViewPresenting (fake "UIViewController")
 * Timers firing due to passage of "time"
***********************/

class AppLifecycle {
    let appProxy: AppProxy

    init(appProxy: AppProxy) {
        self.appProxy = appProxy
    }

    func bootApp() {
        launchApp()
        transitionAppToForeground()
    }

    func launchApp() {
        appProxy.willFinishLaunchingWithOptions()
        appProxy.didFinishLaunchingWithOptions()
    }

    func transitionAppToForeground() {
        appProxy.didBecomeActive()
    }
}

class ViewPresentingLifecycle {
    func appear(viewPresenting: ViewPresenting) {
        viewPresenting.viewDidAppear(false)
        //....
    }
}
