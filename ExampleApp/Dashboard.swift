import UIKit
import Swinject

class DashboardViewModel {
    private let screen: Screenable
    weak var presenter: DashboardViewController?
    let appContainer: Resolvable

    init(appContainer: Resolvable, screen: Screenable) {
        self.appContainer = appContainer
        self.screen = screen
    }

    var mainLabelString: String {
        return "sth from the viewModel"
    }

    var deviceRemark: String {
        return "i see your device size is \(screen.bounds.width)x\(screen.bounds.height)"
    }

    func didTapSlideUpButton() {
        let slideUp = appContainer.resolve(SlideUpViewController.self)!
        let nav = UINavigationController(rootViewController: slideUp)
        presenter?.pushImportantModal(nav)
    }
}

class DashboardViewController: UIViewController {
    var viewModel: DashboardViewModel

    @IBAction func didTapSlideUpButton(sender: AnyObject) {
        viewModel.didTapSlideUpButton()
    }

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayColor()
    }

    func pushImportantModal(viewPresenter: UIViewController) {
        presentViewController(viewPresenter, animated: true, completion: nil)
    }
}
