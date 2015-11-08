@testable import ExampleApp
import XCTest
import Swinject

class ExampleAppTests: XCTestCase {

    var appContainer: Container!
    var appProxy: AppProxy!

    override func setUp() {
        super.setUp()

        appContainer = SpecContainerFactory.createContainer()
        appProxy = appContainer.resolve(AppProxy.self)
    }

    func testAppCanLaunch() {
        XCTAssert(appProxy.willFinishLaunchingWithOptions(), "must return `true`")
        appProxy.didFinishLaunchingWithOptions()
        transitionAppToForeground()
        XCTAssert(fakeDashboard.someThingOnThePage == "sth from the viewModel")
    }

    func launchApp() {
        appProxy.willFinishLaunchingWithOptions()
        appProxy.didFinishLaunchingWithOptions()
        transitionAppToForeground()
    }

    func transitionAppToForeground() {
        appProxy.didBecomeActive()
    }

    var fakeWindow: Windowable {
        return appProxy.window
    }

    var fakeDashboard: FakeDashboardPresenter {
        return fakeWindow.rootViewPresenter as! FakeDashboardPresenter
    }
}
