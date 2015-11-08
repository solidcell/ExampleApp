import UIKit
@testable import ExampleApp

class FakeWindow: Windowable {
    var rootViewPresenter: ViewPresenting?
    
    func makeKeyAndVisible() {
    }

    var real: UIWindow {
        fatalError("fakes should never be asked for a real representation")
    }
}

class FakeDashboardPresenter: DashboardPresenting {
    let viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }

    var real: UIViewController {
        fatalError("fakes should never be asked for a real representation")
    }

    var someThingOnThePage: String {
      return viewModel.mainLabelString
    }
}