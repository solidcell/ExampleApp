import UIKit

func isRunningTests() -> Bool {
    return NSClassFromString("XCTestCase") != nil
}


class UnitTestsAppDelegate: UIResponder, UIApplicationDelegate
{
}

if isRunningTests() {
    UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(UnitTestsAppDelegate))
} else {
    UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(AppDelegate))
}