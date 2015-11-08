@testable import ExampleApp
import Foundation
import Swinject

class SpecContainerFactory {

    static func createContainer() -> Container {
        let c = Container()

        ContainerFactory.registerMainObjectGraph(c)
        self.registerLeafObjects(c)

        return c
    }

    static func registerLeafObjects(c: Container) -> Container {

        c.register(Screenable.self) { r in
            FakeScreen()
        }

        c.register(Windowable.self) { r in
            FakeWindow()
        }

        c.register(DashboardPresenting.self) { r in
            let viewModel = r.resolve(DashboardViewModel.self)!
            return FakeDashboardPresenter(viewModel: viewModel)
        }

        return c
    }
}
