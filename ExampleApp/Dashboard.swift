import UIKit
import Swinject

protocol SlideUpPresenting: ViewPresenting {
}

class SlideUpViewController: UIViewController, SlideUpPresenting {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.greenColor()
    }
}

class DashboardViewModel {
    private let screen: Screenable
    // TODO binding wouldn't require knowing about the view presenter
    weak var presenter: DashboardPresenting?
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

    func viewDidAppear() {
        let slideUp = appContainer.resolve(SlideUpPresenting.self)!
        presenter?.pushImportantModal(slideUp)
    }
}

protocol DashboardPresenting: class, ViewPresenting {
    var viewModel: DashboardViewModel { get }
    func viewDidAppear(animated: Bool)
    func pushImportantModal(viewPresenter: ViewPresenting)
}

class DashboardViewController: UIViewController, DashboardPresenting {
    var viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blueColor()
        
        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = viewModel.mainLabelString
        view.addSubview(label)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.viewDidAppear()
    }

    func pushImportantModal(viewPresenting: ViewPresenting) {
        let vc = viewPresenting.real
        presentViewController(vc, animated: true, completion: nil)
    }
}