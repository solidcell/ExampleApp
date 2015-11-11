@testable import ExampleApp
import UIKit

/***********************
 Leaf Objects - Fake Implementations
 
 These are the leaves of the object graph, representing sources of
 input and output: view controllers, configurations, network libraries, etc.
 
 These replace real implementations during tests
***********************/

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

// Replaces a UIViewController
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
