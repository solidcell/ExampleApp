import UIKit
import Swinject

/***********************
 The entry point for iOS
 
 It creates the appropriate dependency injection bindings,
 creates the AppProxy and forwards calls to it, and
 sets the window.
 
 It is not part of the integration tests. Instead, the tests
 will play much the same role from this perspective. This allows
 you to start and control the app in the same manner as iOS does.
***********************/

// TODO consider using AppDelegate only, again
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appContainer: Container!
    var appProxy: AppProxy!

    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        appContainer = ContainerFactory.createContainer()
        appProxy = appContainer.resolve(AppProxy.self)

        let windowable = appProxy.window
        window = windowable.real

        return appProxy.willFinishLaunchingWithOptions()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return appProxy.didFinishLaunchingWithOptions()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        return appProxy.didBecomeActive()
    }
}

