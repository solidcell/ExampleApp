@testable import ExampleApp
import Foundation
import Swinject

class SpecContainerFactory {

    static func createContainer() -> Container {
        return ContainerFactory.registerServices(
            screen: { FakeScreen() },
            window: { _ in FakeWindow() },
            dashboard: { viewModel in FakeDashboardPresenter(viewModel: viewModel) }
        )
    }
}
