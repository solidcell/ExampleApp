import UIKit

// MARK: View Presenter

protocol ViewPresenting {
    var real: UIViewController { get }
    func viewDidAppear(animated: Bool)
    func presentViewPresenter(viewPresenterToPresent: ViewPresenting, animated flag: Bool, completion: (() -> Void)?)
}

protocol ViewLifecycleNotified {
    func viewDidAppear(animated: Bool)
}

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

// MARK: Window

protocol Windowable {
    var real: UIWindow { get }
    var rootViewPresenter: ViewPresenting? { get set }
    func makeKeyAndVisible()
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

// MARK: Screen

protocol Screenable {
    var bounds: CGRect { get }
}

extension UIScreen: Screenable {
}