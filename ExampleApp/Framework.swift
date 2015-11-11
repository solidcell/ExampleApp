import UIKit

//MARK: View Models

protocol ViewLifecycleNotified {
    func viewDidAppear(animated: Bool)
}

// This is a convenience base class for view models
class BaseViewLifecycleNotified: ViewLifecycleNotified {
    func viewDidAppear(animated: Bool) {}
}

//MARK: Leaf Node Protocols

protocol ViewPresenting {
    var real: UIViewController { get }
    func viewDidAppear(animated: Bool)
    func presentViewPresenter(viewPresenterToPresent: ViewPresenting, animated flag: Bool, completion: (() -> Void)?)
}

protocol Windowable {
    var real: UIWindow { get }
    var rootViewPresenter: ViewPresenting? { get set }
    func makeKeyAndVisible()
}

protocol Screenable {
    var bounds: CGRect { get }
}