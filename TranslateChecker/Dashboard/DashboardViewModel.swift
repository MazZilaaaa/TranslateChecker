import Foundation

protocol DashboardViewModel: ObservableObject {
    func trainingDidTap(wordsCount: Int, roundTime: TimeInterval)
}

final class DashboardViewModelImpl: ObservableObject {
    weak var output: DashboardOutput?
}

extension DashboardViewModelImpl: DashboardInput {
}

extension DashboardViewModelImpl: DashboardViewModel {
    
    func trainingDidTap(wordsCount: Int, roundTime: TimeInterval) {
        // we can improve dashboard view to provide proper words count and round time
        output?.trainingDidTap(wordsCount: wordsCount, roundTime: roundTime)
    }
}
