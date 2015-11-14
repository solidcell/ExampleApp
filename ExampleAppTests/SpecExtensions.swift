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

class BogusSender { }

extension SlideUpViewController {
    var mainLabelText: String? {
        return mainLabel.text
    }

    func tapShinyButton() {
        didTapShinyButton(BogusSender())
    }
}

extension ViewPresenter {
    var viewLifecycle: ViewLifecycle {
        return ViewLifecycle()
    }

    override var presentedViewController: UIViewController? {
        return vp_presentedViewPresenter
    }
    override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let viewPresenterToPresent = viewControllerToPresent as? ViewPresenter {
            vp_presentedViewPresenter = viewPresenterToPresent
            viewLifecycle.appear(viewPresenterToPresent)
        }
    }
}