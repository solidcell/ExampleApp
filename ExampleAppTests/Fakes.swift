@testable import ExampleApp

/***********************
 Custom Leaf Objects - Fake Implementations
 
 These are the leaves of the object graph, representing sources of
 input and output: view controllers, configurations, network libraries, etc.
 
 These replace real implementations during tests
***********************/

class FakeSlideUpPresenter: FakeViewPresenter, SlideUpPresenting {
    init() {
        super.init(viewLifecycleNotified: nil)
    }
}

class FakeDashboardPresenter: FakeViewPresenter, DashboardPresenting {
    let viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(viewLifecycleNotified: viewModel)
    }

    var someThingOnThePage: String {
        return viewModel.mainLabelString
    }

    var deviceRemark: String {
        return viewModel.deviceRemark
    }

    func pushImportantModal(viewPresenter: ViewPresenting) {
        presentViewPresenter(viewPresenter)
    }
}