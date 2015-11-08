import Foundation
import UIKit
@testable import ExampleApp

class FakeDashboardPresenter: DashboardPresenting {
    var viewController: UIViewController {
        return UIViewController() // TODONOW get rid of this?
    }

    var someThingOnThePage: String {
      return "sth from the viewModel"
    }
}