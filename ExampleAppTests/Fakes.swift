@testable import ExampleApp
import UIKit

/***********************
 Custom Leaf Objects - Fake Implementations
 
 These are the leaves of the object graph, representing sources of
 input and output: view controllers, configurations, network libraries, etc.
 
 These replace real implementations during tests, allowing us to:
   * Remember inputs, so they can be asserted upon.
   * Trigger outputs, faking external behavior.
***********************/

class FakeSlideUpPresenter: SlideUpViewController {
}

class FakeDashboardPresenter: DashboardViewController {
    var someThingOnThePage: String {
        return viewModel.mainLabelString
    }

    var deviceRemark: String {
        return viewModel.deviceRemark
    }
}

extension ViewPresenter {
    override var presentedViewController: UIViewController? {
        return internalPresentedViewController
    }
    override public func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        internalPresentedViewController = viewControllerToPresent
    }
}