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

    func testLotsOfStuff() {
        appLifecycle.bootApp()
        XCTAssert(dashboard.visible)
        XCTAssert(dashboard.somethingOnThePage == "sth from the viewModel")
        XCTAssert(dashboard.deviceRemark == "i see your device size is 100.0x150.0")
        dashboard.tapSlideUpButton()
        XCTAssert(slideUp.mainLabelText == "you clicked the button 0 times")
        slideUp.tapShinyButton()
        XCTAssert(slideUp.mainLabelText == "you clicked the button 1 time")
        slideUp.tapShinyButton()
        XCTAssert(slideUp.mainLabelText == "you clicked the button 2 times")
        XCTAssert(!dashboard.visible)
        slideUp.tapDoneButton()
        XCTAssert(dashboard.visible)
    }

    var fakeWindow: Windowable {
        return appProxy.window
    }

    var dashboard: DashboardViewController {
        return fakeWindow.rootViewController as! DashboardViewController
    }

    var slideUp: SlideUpViewController {
        let nav = dashboard.presentedViewController as! UINavigationController
        return nav.topViewController as! SlideUpViewController
    }
}
