import UIKit
import Swinject

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

