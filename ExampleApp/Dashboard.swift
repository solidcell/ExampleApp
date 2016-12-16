import UIKit
import Swinject

class DashboardViewModel {
    private let screen: Screenable

    init(screen: Screenable) {
        self.screen = screen
    }

    var mainLabelString: String {
        return "sth from the viewModel"
    }

    var deviceRemark: String {
        return "i see your device size is \(screen.bounds.width)x\(screen.bounds.height)"
    }

}

class DashboardViewController: UIViewController {
    var viewModel: DashboardViewModel
    let appContainer: Resolvable

    @IBOutlet weak var deviceRemarkLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBAction func didTapSlideUpButton(sender: AnyObject) {
        let slideUp = appContainer.resolve(SlideUpViewController.self)!
        let nav = UINavigationController(rootViewController: slideUp)
        presentViewController(nav, animated: true, completion: nil)
    }

    init(appContainer: Resolvable, viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        self.appContainer = appContainer
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayColor()
        mainLabel.text = viewModel.mainLabelString
        deviceRemarkLabel.text = viewModel.deviceRemark
    }
}
