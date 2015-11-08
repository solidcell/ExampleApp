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