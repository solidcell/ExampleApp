@testable import ExampleApp
import XCTest
import Swinject

class ExampleAppTests: XCTestCase {

    var appContainer: Container!
    var appProxy: AppProxy!
    var appLifecycle: AppLifecycle!

    override func setUp() {
        super.setUp()

        appContainer = SpecContainerFactory.createContainer()
        appProxy = appContainer.resolve(AppProxy.self)
        appLifecycle = AppLifecycle(appProxy: appProxy)
    }

    func testAppCanLaunch() {
        appLifecycle.bootApp()
        XCTAssert(fakeDashboard.someThingOnThePage == "sth from the viewModel")
        XCTAssert(fakeDashboard.deviceRemark == "i see your device size is 100.0x150.0")
        let _ = fakeSlideUp // to test for now that there is a fake slide up at the forefront
    }

    var fakeWindow: Windowable {
        return appProxy.window as! FakeWindow
    }

    var fakeDashboard: FakeDashboardPresenter {
        return fakeWindow.rootViewPresenter as! FakeDashboardPresenter
    }

    var fakeSlideUp: FakeSlideUpPresenter {
        return fakeDashboard.presentedViewPresenter as! FakeSlideUpPresenter
    }
}
