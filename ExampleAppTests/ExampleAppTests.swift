import XCTest
import Swinject
@testable import ExampleApp

class SpecContainerFactory {

    static func createContainer() -> Container {
        let c = ContainerFactory.createContainer()

        c.register(Windowable.self) { r in
            FakeWindow()
        }

        c.register(DashboardPresenting.self) { r in
            FakeDashboardPresenter()
        }

        return c
    }
}

class ExampleAppTests: XCTestCase {

    var appContainer: Container!
    var appProxy: AppProxy!

    var fakeWindow: Windowable {
        return appProxy.window
    }

    var fakeDashboard: FakeDashboardPresenter {
        return fakeWindow.rootViewPresenter as! FakeDashboardPresenter
    }

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
}
