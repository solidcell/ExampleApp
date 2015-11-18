@testable import ExampleApp
import UIKit

/***********************
 Custom Leaf Objects - Spec Extensions

 These extensions help expose details for spec purposes.
   * Hide the implementation details for assertions.
   * Remember inputs, so they can be asserted upon.
   * Trigger outputs, faking external behavior.
***********************/

extension ZZZViewController {
    override var presentedViewController: UIViewController? {
        return vp_presentedViewController
    }

    override var presentingViewController: UIViewController? {
        return vp_presentingViewController
    }
}

public class ViewDelegate: ZZZViewDelegate {
    weak var viewController: ZZZViewController?
    let viewLifecycle = ViewLifecycle()

    func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        viewController?.vp_presentedViewController = viewControllerToPresent
        viewLifecycle.appear(viewControllerToPresent)

        guard let vc = viewControllerToPresent as? ZZZViewController else { fatalError() }
        vc.vp_presentingViewController = viewController
    }

    func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        if let presentedViewController = viewController?.vp_presentedViewController as? ZZZViewController {
            presentedViewController.vp_presentingViewController = nil
            viewLifecycle.disappear(presentedViewController, animated: false)
        }

        viewController?.vp_presentedViewController = nil
        viewLifecycle.appear(viewController!)
    }
}

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

class BogusSender { }

extension ZZZViewController {
    var visible: Bool {
        return presentedViewController == nil
    }

    func assertVisible() {
        assert(visible)
    }
}