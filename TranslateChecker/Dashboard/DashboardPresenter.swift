import Foundation

final class DashboardViewModel: ObservableObject {
    @Published var tmp: Bool = false
    
    weak var output: DashboardOutput?
    
    init(output: DashboardOutput? = nil) {
        self.output = output
    }
    
    func toggle() {
        tmp.toggle()
    }
}

extension DashboardPresenter: DashboardInput {
}
