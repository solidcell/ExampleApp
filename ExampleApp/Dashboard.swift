import UIKit
import Swinject

protocol SlideUpPresenting: ViewPresenting {
}

class SlideUpViewController: ViewPresentingViewController, SlideUpPresenting {
    init() {
        super.init(viewLifecycleNotified: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.greenColor()
    }
}

class DashboardViewModel: BaseViewLifecycleNotified {
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

    override func viewDidAppear(animated: Bool) {
        let slideUp = appContainer.resolve(SlideUpPresenting.self)!
        presenter?.pushImportantModal(slideUp)
    }
}

protocol DashboardPresenting: class, ViewPresenting {
    var viewModel: DashboardViewModel { get }
    func pushImportantModal(viewPresenter: ViewPresenting)
}

class DashboardViewController: ViewPresentingViewController, DashboardPresenting {
    var viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(viewLifecycleNotified: viewModel)
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

    func pushImportantModal(viewPresenting: ViewPresenting) {
        presentViewPresenter(viewPresenting, animated: true, completion: nil)
    }
}