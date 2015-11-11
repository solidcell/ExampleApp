import Swinject
import UIKit

class ContainerFactory {

    // This is the configuration for the real app
    static func createContainer() -> Container {
        return self.registerServices(
            screen: { UIScreen.mainScreen() },
            window: { bounds in Window(frame: bounds) },
            dashboard: { viewModel in DashboardViewController(viewModel: viewModel) },
            slideUp: { SlideUpViewController() }
        )
    }

    // This is the configuration for the shared object graph
    static func registerServices(screen
        screen: () -> Screenable,
        window: (CGRect) -> Windowable,
        dashboard: (DashboardViewModel) -> DashboardPresenting,
        slideUp: () -> SlideUpPresenting
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

        // MARK: Leaf Objects

        c.register(Screenable.self) { _ in
            screen()
        }.inObjectScope(.Container)

        c.register(Windowable.self) { r in
            let screen = r.resolve(Screenable.self)!
            return window(screen.bounds)
        }.inObjectScope(.Container)

        c.register(DashboardPresenting.self) { r in
            let viewModel = r.resolve(DashboardViewModel.self)!
            let dashboard = dashboard(viewModel)
            // TODO breaking law of demeter
            dashboard.viewModel.presenter = dashboard
            return dashboard
        }

        c.register(SlideUpPresenting.self) { _ in
            slideUp()
        }

        return c
    }
}