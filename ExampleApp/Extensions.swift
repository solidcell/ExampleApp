import UIKit

// MARK: View

protocol ViewPresenting {
    var viewController: UIViewController { get }
}

extension UIViewController: ViewPresenting {
    var viewController: UIViewController {
        return self
    }
}

// MARK: Window

protocol Windowable {
    var window: UIWindow { get }
    var rootViewPresenter: ViewPresenting? { get set }
    func makeKeyAndVisible()
}

extension UIWindow: Windowable {
    // TODO why does this need `public override`?
    public override var window: UIWindow {
        return self
    }

    var rootViewPresenter: ViewPresenting? {
        set(newValue) {
            self.rootViewController = newValue?.viewController
        }
        get {
            return self.rootViewController
        }
    }
}

// MARK: Screen

protocol Screenable: class {
    var bounds: CGRect { get }
}

extension UIScreen: Screenable {
}