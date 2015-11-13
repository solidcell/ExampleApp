@testable import ExampleApp
import UIKit

/***********************
 Leaf Objects - Fake Implementations
 
 These are the leaves of the object graph, representing sources of
 input and output: view controllers, configurations, network libraries, etc.
 
 These replace real implementations during tests
***********************/

class FakeScreen: Screenable {
    var bounds = CGRect(x: 0, y: 0, width: 100, height: 150)
}

class FakeWindow: Windowable {
    let viewLifecycle = ViewLifecycle()

    var rootViewController: UIViewController? {
        didSet {
            viewLifecycle.appear(rootViewController!)
        }
    }
    
    func makeKeyAndVisible() {
    }

    var real: UIWindow {
        fatalError("fakes should never be asked for a real representation")
    }
}
