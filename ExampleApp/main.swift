import UIKit

func isRunningTests() -> Bool {
    return NSClassFromString("XCTestCase") != nil
}

class SpecAppDelegate: UIResponder, UIApplicationDelegate {
}

if isRunningTests() {
    UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(SpecAppDelegate))
} else {
    UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(AppDelegate))
}