import UIKit

/***********************
 Leaf Objects - Real Implementations
 
 These are the leaves of the object graph, representing sources of
 input and output: view controllers, configurations, network libraries, etc.
 
 These are replaced by fake implementations during tests
***********************/

class ViewPresenter: UIViewController {
    // TODONOW can we do away with this somehow? It's needed for
    // an extension in the specs since:
    // an extension can't define new properties, needed because:
    // an extension can't set presentedViewController [would be the best]
    var vp_presentedViewController: UIViewController?

    let viewLifecycleNotified: ViewLifecycleNotified?

    convenience init() {
        self.init(viewLifecycleNotified: nil)
    }

    init(viewLifecycleNotified: ViewLifecycleNotified?) {
        self.viewLifecycleNotified = viewLifecycleNotified
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
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
}

extension UIScreen: Screenable {
}