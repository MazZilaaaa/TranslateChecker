import SwiftUI

typealias DashboardModule = (controller: UIViewController, input: DashboardInput)

final class DashboardConfigurator {
    func configure(output: DashboardOutput? = nil) -> DashboardModule {
        configureWithSwiftUI(output: output)
    }
    
    private func configureWithSwiftUI(output: DashboardOutput? = nil) -> DashboardModule {
        let viewModel = DashboardViewModelImpl()
        viewModel.output = output
        let view = DashboardView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        return (controller, viewModel)
        
    }
}
