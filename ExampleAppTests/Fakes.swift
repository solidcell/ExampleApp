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

class FakeViewPresenter: ViewPresenting {
    // TODO make this non-optional
    let viewLifecycleNotified: ViewLifecycleNotified?
    let viewPresentingLifecyle = ViewPresentingLifecycle()

    init(viewLifecycleNotified: ViewLifecycleNotified?) {
        self.viewLifecycleNotified = viewLifecycleNotified
    }

    func viewDidAppear(animated: Bool) {
        self.viewLifecycleNotified?.viewDidAppear(animated)
    }

    var presentedViewPresenter: ViewPresenting?

    func presentViewPresenter(viewPresenterToPresent: ViewPresenting) {
        presentedViewPresenter = viewPresenterToPresent
        viewPresentingLifecyle.appear(presentedViewPresenter!)
    }

    func presentViewPresenter(viewPresenterToPresent: ViewPresenting, animated _: Bool, completion _: (() -> Void)?) {
        presentViewPresenter(viewPresenterToPresent)
    }

    var real: UIViewController {
        fatalError()
    }
}

class FakeSlideUpPresenter: FakeViewPresenter, SlideUpPresenting {
    init() {
        super.init(viewLifecycleNotified: nil)
    }
}

class FakeDashboardPresenter: FakeViewPresenter, DashboardPresenting {
    let viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(viewLifecycleNotified: viewModel)
    }

    var someThingOnThePage: String {
        return viewModel.mainLabelString
    }

    var deviceRemark: String {
        return viewModel.deviceRemark
    }

    func pushImportantModal(viewPresenter: ViewPresenting) {
        presentViewPresenter(viewPresenter)
    }
}