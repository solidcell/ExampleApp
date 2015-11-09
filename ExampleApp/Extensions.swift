import UIKit

// MARK: View Presenter

protocol ViewPresenting {
    var real: UIViewController { get }
    var presentedViewPresenter: ViewPresenting? { get }
    func viewDidAppear()
}

extension UIViewController: ViewPresenting {
    var real: UIViewController {
        return self
    }

    var presentedViewPresenter: ViewPresenting? {
        return presentedViewController
    }

    func viewDidAppear() {
    }
}

// MARK: Window

protocol Windowable {
    var real: UIWindow { get }
    var rootViewPresenter: ViewPresenting? { get set }
    func makeKeyAndVisible()
}

extension UIWindow: Windowable {
    var real: UIWindow {
        return self
    }

    var rootViewPresenter: ViewPresenting? {
        set(newValue) {
            self.rootViewController = newValue?.real
        }
        get {
            return self.rootViewController
        }
    }
}

// MARK: Screen

protocol Screenable {
    var bounds: CGRect { get }
}

extension UIScreen: Screenable {
}