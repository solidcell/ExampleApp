import Swinject
import UIKit

class ContainerFactory {

    // This is the configuration for the real app
    static func createContainer() -> Container {
        return self.registerServices(
            screen: { UIScreen.mainScreen() }
        )
    }

    // This is the configuration for the shared object graph
    static func registerServices(screen
        screen: () -> Screenable
        ) -> Container
    {
        let c = Container()

        // MARK: Shared Object Graph

        c.register(AppProxy.self) { r in
            return AppProxy(appContainer: r, window: r.resolve(UIWindow.self)!)
        }

        c.register(DashboardViewModel.self) { r in
            let screen = r.resolve(Screenable.self)!
            return DashboardViewModel(screen: screen)
        }

        c.register(DashboardController.self) { r in
            return DashboardController(appContainer: r)
        }

        c.register(DashboardViewController.self) { r in
            let viewModel = r.resolve(DashboardViewModel.self)!
            let controller = r.resolve(DashboardController.self)!
            let dashboard = DashboardViewController(viewModel: viewModel,
                controller: controller)
            dashboard.controller.presenter = dashboard
            return dashboard
        }

        c.register(SlideUpViewController.self) { _ in
            return SlideUpViewController()
        }

        // MARK: Leaf Objects

        c.register(Screenable.self) { _ in
            screen()
        }.inObjectScope(.Container)

        return c
    }
}