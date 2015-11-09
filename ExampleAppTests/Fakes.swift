import UIKit
@testable import ExampleApp

class FakeScreen: Screenable {
    var bounds = CGRect(x: 0, y: 0, width: 100, height: 150)
}

class FakeWindow: Windowable {
    let viewPresentingLifecyle = ViewPresentingLifecycle()

    var rootViewPresenter: ViewPresenting? {
        didSet {
            viewPresentingLifecyle.appear(rootViewPresenter!)
        }
    }
    
    func makeKeyAndVisible() {
    }

    var real: UIWindow {
        fatalError("fakes should never be asked for a real representation")
    }
}

class FakeSlideUpPresenter: SlideUpPresenting {
    var presentedViewPresenter: ViewPresenting?

    var real: UIViewController {
        fatalError("fakes should never be asked for a real representation")
    }

    func viewDidAppear() {
    }
}

class FakeDashboardPresenter: DashboardPresenting {
    let viewModel: DashboardViewModel
    var presentedViewPresenter: ViewPresenting?

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }

    var real: UIViewController {
        // TODO is there a better solution?
        fatalError("fakes should never be asked for a real representation")
    }

    // TODO view lifecycle methods should share viewModel calls/logic with the real impls
    func viewDidAppear() {
        viewModel.viewDidAppear()
    }

    func viewDidAppear(animated: Bool = false) {
        return viewModel.viewDidAppear()
    }

    var someThingOnThePage: String {
        return viewModel.mainLabelString
    }

    var deviceRemark: String {
        return viewModel.deviceRemark
    }

    func pushImportantModal(viewPresenter: ViewPresenting) {
        presentedViewPresenter = viewPresenter
    }
}