import Foundation

protocol DashboardViewModel: ObservableObject {
    func showAllWordsDidTap()
    func trainingDidTap()
}

final class DashboardViewModelImpl: ObservableObject {
    weak var output: DashboardOutput?
}

extension DashboardViewModelImpl: DashboardInput {
}

extension DashboardViewModelImpl: DashboardViewModel {
    
    func trainingDidTap() {
        output?.trainingDidTap()
    }
    
    func showAllWordsDidTap() {
        output?.showAllWordsDidTap()
    }
}
