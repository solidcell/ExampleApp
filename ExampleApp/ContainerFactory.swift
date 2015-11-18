import Swinject
import UIKit

class ContainerFactory {

    // This is the configuration for the real app
    static func createContainer() -> Container {
        return self.registerServices(
            screen: { UIScreen.mainScreen() },
            window: { bounds in Window(frame: bounds) },
            viewDelegate: { nil }
        )
    }

    // This is the configuration for the shared object graph
    static func registerServices(screen
        screen: () -> Screenable,
        window: (CGRect) -> Windowable,
        viewDelegate: () -> ZZZViewDelegate?
        ) -> Container
    {
        let c = Container()

        // MARK: Shared Object Graph

        c.register(AppProxy.self) { r in
            let window = r.resolve(Windowable.self)!
            return AppProxy(appContainer: r, window: window)
        }

        c.register(DashboardViewModel.self) { r in
            let screen = r.resolve(Screenable.self)!
            return DashboardViewModel(appContainer: r, screen: screen)
        }

        c.register(DashboardViewController.self) { r in
            let viewModel = r.resolve(DashboardViewModel.self)!
            let dashboard = DashboardViewController(viewModel: viewModel, viewDelegate: viewDelegate())
            dashboard.viewModel.presenter = dashboard
            return dashboard
        }

        c.register(SlideUpViewController.self) { _ in
            return SlideUpViewController(viewDelegate: viewDelegate())
        }

        // MARK: Leaf Objects

        c.register(Screenable.self) { _ in
            screen()
        }.inObjectScope(.Container)

        c.register(Windowable.self) { r in
            let screen = r.resolve(Screenable.self)!
            return window(screen.bounds)
        }.inObjectScope(.Container)

        return c
    }
}