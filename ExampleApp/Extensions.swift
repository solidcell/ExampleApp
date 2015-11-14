import UIKit

/***********************
 Leaf Objects - Real Implementations
 
 These are the leaves of the object graph, representing sources of
 input and output: view controllers, configurations, network libraries, etc.
 
 These are replaced by fake implementations during tests
***********************/

// TODONOW consider if this class is needed at all, since we could
// override UIViewController lifecycle methods with an extension.
// However, a solution to get rid of vp_presentedViewController is needed
class ViewPresenter: UIViewController {
    // TODONOW can we do away with this somehow? It's needed for
    // an extension in the specs since:
    // an extension can't define new properties, needed because:
    // an extension can't set presentedViewController [would be the best]
    var vp_presentedViewController: UIViewController?
}

class Window: UIWindow, Windowable {
    var real: UIWindow {
        return self
    }
}

extension UIScreen: Screenable {
}