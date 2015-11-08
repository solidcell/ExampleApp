import Swinject
import UIKit

class ContainerFactory {

    static func createContainer() -> Container {
        let c = Container()

        self.registerMainObjectGraph(c)
        self.registerLeafObjects(c)

        return c
    }

    static func registerMainObjectGraph(c: Container) -> Container {

        c.register(AppProxy.self) { r in
            let window = r.resolve(Windowable.self)!
            return AppProxy(appContainer: r, window: window)
        }

        c.register(DashboardViewModel.self) { r in
            let screen = r.resolve(Screenable.self)!
            return DashboardViewModel(screen: screen)
        }

        return c
    }

    static func registerLeafObjects(c: Container) -> Container {

        c.register(Screenable.self) { r in
            UIScreen.mainScreen()
        }

        c.register(Windowable.self) { r in
            let screen = r.resolve(Screenable.self)!
            return UIWindow(frame: screen.bounds)
        }

        c.register(DashboardPresenting.self) { r in
            let viewModel = r.resolve(DashboardViewModel.self)!
            return DashboardViewController(viewModel: viewModel)
        }

        return c
    }
}