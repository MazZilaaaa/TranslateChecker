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
        // we can improve dashboard view to provide proper words count
        output?.trainingDidTap(wordsCount: 15)
    }
    
    func showAllWordsDidTap() {
        output?.showAllWordsDidTap()
    }
}
