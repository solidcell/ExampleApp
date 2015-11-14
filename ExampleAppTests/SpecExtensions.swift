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
        assertVisible()
        return viewModel.mainLabelString
    }

    var deviceRemark: String {
        assertVisible()
        return viewModel.deviceRemark
    }

    func tapSlideUpButton() {
        assertVisible()
        didTapSlideUpButton(BogusSender())
    }
}

extension SlideUpViewController {
    var mainLabelText: String? {
        assertVisible()
        return mainLabel.text
    }

    func tapShinyButton() {
        assertVisible()
        didTapShinyButton(BogusSender())
    }

    func tapDoneButton() {
        assertVisible()
        didTapDoneButton(BogusSender())
    }
}

extension ViewPresenter {
    var viewLifecycle: ViewLifecycle {
        return ViewLifecycle()
    }

    func assertVisible() {
        assert(visible, "This action is invalid because the view is not visible")
    }

    var visible: Bool {
        return vp_presentedViewPresenter == nil
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

class BogusSender { }