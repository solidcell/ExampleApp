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

    func tapDoneButton() {
        didTapDoneButton(BogusSender())
    }
}

extension ViewPresenter {
    var viewLifecycle: ViewLifecycle {
        return ViewLifecycle()
    }

    override var presentedViewController: UIViewController? {
        return vp_presentedViewPresenter
    }
    override var presentingViewController: UIViewController? {
        return vp_presentingViewPresenter
    }
    override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let viewPresenterToPresent = viewControllerToPresent as? ViewPresenter {
            vp_presentedViewPresenter = viewPresenterToPresent
            viewLifecycle.appear(viewPresenterToPresent)
            viewPresenterToPresent.vp_presentingViewPresenter = self
        }
    }
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        if let presentedViewPresenter = vp_presentedViewPresenter {
            vp_presentedViewPresenter = nil
            viewLifecycle.disappear(presentedViewPresenter)
            presentedViewPresenter.vp_presentingViewPresenter = nil
        }
    }
}