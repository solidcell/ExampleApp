import UIKit

protocol ZZZViewDelegate {
    weak var viewController: ZZZViewController? { get set }
    func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?)
}

class ZZZViewController: UIViewController {
    let viewDelegate: ZZZViewDelegate?

    init(viewDelegate: ZZZViewDelegate?) {
        self.viewDelegate = viewDelegate
        super.init(nibName: nil, bundle: nil)
        self.viewDelegate?.viewController = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    var vp_presentedViewController: UIViewController?
    var vp_presentingViewController: UIViewController?

    override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let viewDelegate = viewDelegate {
            viewDelegate.presentViewController(viewControllerToPresent, animated: flag, completion: completion)
        } else {
            super.presentViewController(viewControllerToPresent, animated: flag, completion: completion)
        }
    }

    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        if let viewDelegate = viewDelegate {
            viewDelegate.dismissViewControllerAnimated(flag, completion: completion)
        } else {
            super.dismissViewControllerAnimated(flag, completion: completion)
        }
    }
}

