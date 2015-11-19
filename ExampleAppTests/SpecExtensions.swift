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

class BogusSender { }

extension UIViewController {
    var visible: Bool {
        return presentedViewController == nil
    }

    func assertVisible() {
        assert(visible)
    }
}