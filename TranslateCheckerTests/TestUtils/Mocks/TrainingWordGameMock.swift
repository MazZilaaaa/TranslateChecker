@testable import TranslateChecker

final class TrainingWordGameMock: TrainingWordsGameProtocol {
    var setWordsCount: Int?
    func setWordsCount(_ count: Int) {
        setWordsCount = count
    }
    
    var startCount: Int = .zero
    func start() {
        startCount += 1
    }
    
    var checkRoundStatus: WordPairTranslationStatus?
    func checkRound(with status: TranslateChecker.WordPairTranslationStatus?) {
        self.checkRoundStatus = status
    }
    
    
}
