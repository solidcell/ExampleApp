import UIKit

class DashboardViewModel {
    var mainLabelString: String {
        return "sth from the viewModel"
    }
}

protocol DashboardPresenting: ViewPresenting {
    var viewModel: DashboardViewModel { get }
}

class DashboardViewController: UIViewController, DashboardPresenting {
    let viewModel: DashboardViewModel

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
        self.view.addSubview(label)
    }
}