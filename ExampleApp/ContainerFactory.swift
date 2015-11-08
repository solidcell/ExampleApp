import Swinject
import UIKit

class ContainerFactory {

    static func createContainer() -> Container {
        let c = Container()

        c.register(Screenable.self) { r in
            UIScreen.mainScreen()
        }

        c.register(Windowable.self) { r in
            let screen = r.resolve(Screenable.self)!
            return UIWindow(frame: screen.bounds)
        }

        c.register(AppProxy.self) { r in
            let window = r.resolve(Windowable.self)!
            return AppProxy(appContainer: r, window: window)
        }

        c.register(DashboardPresenting.self) { r in
            DashboardViewController()
        }

        return c
    }
}