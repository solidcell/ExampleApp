@testable import ExampleApp
import XCTest
import Swinject

extension UIView {
    //This assumes that labels, textView and textFields don't have subviews that might have the text
    func checkTextInSubviews(text: String) -> Bool {
        for view in self.subviews {
            if view.checkText(text) {
                return true
            }
        }
        return false
    }

    func checkText(text: String) -> Bool {
        guard self.respondsToSelector("text") else {
            return checkTextInSubviews(text)
        }
        guard let result = self.performSelector("text") else {
            return checkTextInSubviews(text)
        }
        guard let textToCheck = result.takeRetainedValue() as? String else {
            return checkTextInSubviews(text)
        }
        guard textToCheck == text else {
            return checkTextInSubviews(text)
        }
        return true
    }

    func firstViewWithTextInSubviews(text: String) -> UIView? {
        for view in self.subviews {
            if let viewToReturn = view.firstViewWithText(text) {
                return viewToReturn
            }
        }
        return nil
    }

    func firstViewWithText(text: String) -> UIView? {
        guard self.respondsToSelector("text") else {
            return firstViewWithTextInSubviews(text)
        }
        guard let result = self.performSelector("text") else {
            return firstViewWithTextInSubviews(text)
        }
        guard let textToCheck = result.takeRetainedValue() as? String else {
            return firstViewWithTextInSubviews(text)
        }
        guard textToCheck == text else {
            return firstViewWithTextInSubviews(text)
        }
        return self
    }
}

class ExampleAppTests: XCTestCase {

    var appContainer: Container!
    var appProxy: AppProxy!
    var appLifecycle: AppLifecycle!

    override func setUp() {
        super.setUp()

        appContainer = SpecContainerFactory.createContainer()
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let screen = appContainer.resolve(Screenable.self)!
        appContainer.register(UIWindow.self) { r in
            UIWindow(frame: screen.bounds)
        }
        appProxy = appContainer.resolve(AppProxy.self)
        appLifecycle = AppLifecycle(appProxy: appProxy)
    }

    func testLotsOfStuff() {
        self.appLifecycle.bootApp()
        XCTAssert(topMostViewController.view.checkText("Slide Up"))
        XCTAssert(topMostViewController.view.checkText("sth from the viewModel"))
        XCTAssert(topMostViewController.view.checkText("i see your device size is 100.0x150.0"))

        let dashboardViewController = self.topMostViewController as! DashboardViewController
        dashboardViewController.didTapSlideUpButton(UIView())
        XCTAssert(topMostViewController.view.checkText("you clicked the button 0 times"), "button with 0 tap should exist")

        let navigationController = self.topMostViewController as! UINavigationController
        let slideUpViewController = navigationController.topViewController as! SlideUpViewController
        RBTimeLapse.disableAnimationsInBlock { () -> Void in
            slideUpViewController.didTapShinyButton(slideUpViewController.view)
        }
        XCTAssert(topMostViewController.view.checkText("you clicked the button 1 time"), "button with 1 tap should exist")
        RBTimeLapse.disableAnimationsInBlock { () -> Void in
            slideUpViewController.didTapShinyButton(slideUpViewController.view)
        }
        XCTAssert(topMostViewController.view.checkText("you clicked the button 2 times"), "button with 2 tap should exist")
            print("something")


//        slideUp.tapShinyButton()
//        XCTAssert(slideUp.mainLabelText == "you clicked the button 2 times")
//        XCTAssert(!dashboard.visible)
//        RBTimeLapse.disableAnimationsInBlock { () -> Void in
//            self.slideUp.tapDoneButton()
//        }
//        RBTimeLapse.advanceMainRunLoop()
//        XCTAssert(dashboard.visible)
    }

    var topMostViewController: UIViewController {
        let rootViewController = appProxy.window.rootViewController!
        if let presentedViewController = rootViewController.presentedViewController {
            return presentedViewController
        }
        return rootViewController
    }

    var dashboard: DashboardViewController {
        return appProxy.window.rootViewController as! DashboardViewController
    }

    var slideUp: SlideUpViewController {
        let nav = dashboard.presentedViewController as! UINavigationController
        return nav.topViewController as! SlideUpViewController
    }
}
