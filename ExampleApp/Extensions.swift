import UIKit

/***********************
 Leaf Objects - Real Implementations
 
 These are the leaves of the object graph, representing sources of
 input and output: view controllers, configurations, network libraries, etc.
 
 These are replaced by fake implementations during tests
***********************/

// abstract - Use this instead of UIViewController directly
class ViewPresentingViewController: UIViewController, ViewPresenting {
    let viewLifecycleNotified: ViewLifecycleNotified?

    init(viewLifecycleNotified: ViewLifecycleNotified?) {
        self.viewLifecycleNotified = viewLifecycleNotified
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    var real: UIViewController {
        return self
    }

    func presentViewPresenter(viewPresenterToPresent: ViewPresenting, animated flag: Bool, completion: (() -> Void)?) {
        let viewController = viewPresenterToPresent.real
        presentViewController(viewController, animated: flag, completion: completion)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        viewLifecycleNotified?.viewDidAppear(animated)
    }
}

class Window: UIWindow, Windowable {
    var real: UIWindow {
        return self
    }

    var rootViewPresenter: ViewPresenting? {
        didSet {
            rootViewController = rootViewPresenter?.real
        }
    }
}

extension UIScreen: Screenable {
}