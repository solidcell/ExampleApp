import UIKit
@testable import ExampleApp

class FakeWindow: Windowable {
    var rootViewPresenter: ViewPresenting?
    
    func makeKeyAndVisible() {
    }

    var window: UIWindow {
        return UIWindow() //TODO
    }
}

class FakeDashboardPresenter: DashboardPresenting {
    let viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }

    var viewController: UIViewController {
        return UIViewController() // TODONOW get rid of this?
    }

    var someThingOnThePage: String {
      return viewModel.mainLabelString
    }
}