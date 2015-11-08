@testable import ExampleApp
import Foundation
import Swinject

class SpecContainerFactory {

    static func createContainer() -> Container {
        let c = ContainerFactory.createContainer()

        c.register(Windowable.self) { r in
            FakeWindow()
        }

        c.register(DashboardPresenting.self) { r in
            FakeDashboardPresenter()
        }

        return c
    }
}
