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
    var viewController: UIViewController {
        return UIViewController() // TODONOW get rid of this?
    }

    var someThingOnThePage: String {
      return "sth from the viewModel"
    }
}