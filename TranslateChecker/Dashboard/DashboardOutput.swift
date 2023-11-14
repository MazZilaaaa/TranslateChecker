import Foundation

protocol DashboardOutput: AnyObject {
    func trainingDidTap(wordsCount: Int, roundTime: TimeInterval)
}
