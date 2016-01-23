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

class DashboardController {
    weak var presenter: DashboardViewController?
    let appContainer: Resolvable

    init(appContainer: Resolvable) {
        self.appContainer = appContainer
    }

    func didTapSlideUpButton() {
        let slideUp = appContainer.resolve(SlideUpViewController.self)!
        let nav = UINavigationController(rootViewController: slideUp)
        presenter?.pushImportantModal(nav)
    }
}

class DashboardViewController: UIViewController {
    var viewModel: DashboardViewModel
    let controller: DashboardController

    @IBOutlet weak var deviceRemarkLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBAction func didTapSlideUpButton(sender: AnyObject) {
        controller.didTapSlideUpButton()
    }

    init(viewModel: DashboardViewModel, controller: DashboardController) {
        self.viewModel = viewModel
        self.controller = controller
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

    func pushImportantModal(viewPresenter: UIViewController) {
        presentViewController(viewPresenter, animated: true, completion: nil)
    }
}
