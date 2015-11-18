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
        presenter?.pushImportantModal(slideUp)
    }
}

class DashboardViewController: ZZZViewController {
    var viewModel: DashboardViewModel

    @IBAction func didTapSlideUpButton(sender: AnyObject) {
        viewModel.didTapSlideUpButton()
    }

    init(viewModel: DashboardViewModel, viewDelegate: ZZZViewDelegate?) {
        self.viewModel = viewModel
        super.init(viewDelegate: viewDelegate)
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
