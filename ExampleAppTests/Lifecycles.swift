@testable import ExampleApp
import Foundation

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
        viewPresenting.viewDidAppear()
        //....
    }
}
