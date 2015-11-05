import XCTest
@testable import ExampleApp

class ExampleAppTests: XCTestCase {
    var fakeWindow: FakeWindow!
    var appProxy: AppProxy!

    override func setUp() {
        super.setUp()

        self.fakeWindow = FakeWindow()
        self.appProxy = AppProxy(window: fakeWindow)
    }

    func testExample() {
        launchApp()
        let _ = fakeWindow.rootViewController as ViewPresenting?
//        XCTAssert(fakeDashboard)
    }

    func launchApp() {
        appProxy.willFinishLaunchingWithOptions()
        appProxy.didFinishLaunchingWithOptions()
        transitionAppToForeground()
    }

    func transitionAppToForeground() {
        appProxy.applicationDidBecomeActive()
    }
}
