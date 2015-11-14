@testable import ExampleApp
import UIKit

/***********************
 Custom Leaf Objects - Spec Extensions

 These extensions help expose details for spec purposes.
   * Hide the implementation details for assertions.
   * Remember inputs, so they can be asserted upon.
   * Trigger outputs, faking external behavior.
***********************/

extension DashboardViewController {

    var somethingOnThePage: String {
        return viewModel.mainLabelString
    }

    var deviceRemark: String {
        return viewModel.deviceRemark
    }
}

extension SlideUpViewController {

    var mainLabelText: String? {
        return mainLabel.text
    }
}

extension ViewPresenter {
    var viewLifecycle: ViewLifecycle {
        return ViewLifecycle()
    }

    override var presentedViewController: UIViewController? {
        return vp_presentedViewController
    }
    override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        vp_presentedViewController = viewControllerToPresent
        viewLifecycle.appear(viewControllerToPresent)
    }
}