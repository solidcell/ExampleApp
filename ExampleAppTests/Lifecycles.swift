@testable import ExampleApp
import UIKit

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

class ViewLifecycle {
    func appear(viewController: UIViewController) {
        loadView(viewController)
        viewController.viewDidAppear(false)
    }

    func disappear(viewController: UIViewController, animated: Bool) {
        viewController.viewWillDisappear(animated)
        viewController.viewDidDisappear(animated)
    }

    private func loadView(viewController: UIViewController) {
        // load the view and call viewDidLoad
        var _ = viewController.view
    }
}
