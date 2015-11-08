import UIKit

protocol DashboardPresenting: ViewPresenting {
}

class DashboardViewController: UIViewController, DashboardPresenting {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blueColor()
    }
}