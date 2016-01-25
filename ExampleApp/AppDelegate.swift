import UIKit
import Swinject

/***********************
 The entry point for iOS
 
 It creates the appropriate dependency injection bindings,
 creates the AppProxy and forwards calls to it, and
 sets the window. The application object isn't passed in the 
 forward calls as it should be injected into the appProxy,
 which allows us to fake the application object
 
 This class is not part of the integration tests. Instead, the tests
 will play much the same role from this perspective. This allows
 you to start and control the app in the same manner as iOS does.
***********************/

// TODO consider using AppDelegate only, again
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appProxy: AppProxy!

    override init() {
        let appContainer = ContainerFactory.createContainer()
        let screen = appContainer.resolve(Screenable.self)!
        let window = UIWindow(frame: screen.bounds)
        appContainer.register(UIWindow.self) { _ in
            window
        }
        self.window = window
        appProxy = appContainer.resolve(AppProxy.self)
    }

    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        return appProxy.willFinishLaunchingWithOptions()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return appProxy.didFinishLaunchingWithOptions()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        return appProxy.didBecomeActive()
    }
}

