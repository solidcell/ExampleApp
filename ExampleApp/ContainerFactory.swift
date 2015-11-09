import Swinject
import UIKit

class ContainerFactory {

    static func createContainer() -> Container {
        return self.registerServices(
            screen: { UIScreen.mainScreen() },
            window: { bounds in UIWindow(frame: bounds) },
            dashboard: { viewModel in DashboardViewController(viewModel: viewModel) }
        )
    }

    static func registerServices(screen
        screen: () -> Screenable,
        window: (CGRect) -> Windowable,
        dashboard: (DashboardViewModel) -> DashboardPresenting
        ) -> Container
    {
        let c = Container()

        // MARK: Main Object Graph

        c.register(AppProxy.self) { r in
            let window = r.resolve(Windowable.self)!
            return AppProxy(appContainer: r, window: window)
        }

        c.register(DashboardViewModel.self) { r in
            let screen = r.resolve(Screenable.self)!
            return DashboardViewModel(screen: screen)
        }

        // MARK: Leaf Objects

        c.register(Screenable.self) { r in
            screen()
        }.inObjectScope(.Container)

        c.register(Windowable.self) { r in
            let screen = r.resolve(Screenable.self)!
            return window(screen.bounds)
        }.inObjectScope(.Container)

        c.register(DashboardPresenting.self) { r in
            let viewModel = r.resolve(DashboardViewModel.self)!
            return dashboard(viewModel)
        }

        return c
    }
}