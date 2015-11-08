import UIKit
@testable import ExampleApp

class FakeScreen: Screenable {
    var bounds = CGRect(x: 0, y: 0, width: 100, height: 150)
}

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

    var deviceRemark: String {
        return viewModel.deviceRemark
    }
}