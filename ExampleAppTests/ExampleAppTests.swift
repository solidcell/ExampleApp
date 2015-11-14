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
        XCTAssert(dashboard.somethingOnThePage == "sth from the viewModel")
        XCTAssert(dashboard.deviceRemark == "i see your device size is 100.0x150.0")
        XCTAssert(slideUp.mainLabelText == "mainLabel")
        slideUp.tapShinyButton()
        XCTAssert(slideUp.mainLabelText == "you clicked the button 1 time")
    }

    var fakeWindow: Windowable {
        return appProxy.window
    }

    var dashboard: DashboardViewController {
        return fakeWindow.rootViewController as! DashboardViewController
    }

    var slideUp: SlideUpViewController {
        return dashboard.presentedViewController as! SlideUpViewController
    }
}
