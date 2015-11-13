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

protocol Windowable {
    var real: UIWindow { get }
    var rootViewController: UIViewController? { get set }
    func makeKeyAndVisible()
}

protocol Screenable {
    var bounds: CGRect { get }
}