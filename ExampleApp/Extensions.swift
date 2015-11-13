import UIKit

/***********************
 Leaf Objects - Real Implementations
 
 These are the leaves of the object graph, representing sources of
 input and output: view controllers, configurations, network libraries, etc.
 
 These are replaced by fake implementations during tests
***********************/

class ViewPresenter: UIViewController {
    // TODONOW can we do away with this somehow?
    var internalPresentedViewController: UIViewController?
    
    let viewLifecycleNotified: ViewLifecycleNotified?

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