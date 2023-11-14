@testable import TranslateChecker

final  class TrainingWordsGameOutputMock: TrainingWordsGameOutput {
    var didFinishGameScore: TrainingWordsGameScore?
    func didFinishGame(with score: TranslateChecker.TrainingWordsGameScore) {
        didFinishGameScore = score
    }
    
    var didChangeScore: TrainingWordsGameScore?
    func didChangeScore(_ score: TranslateChecker.TrainingWordsGameScore) {
        didChangeScore = score
    }
    
    var didStartLoadingWordsCount: Int = .zero
    func didStartLoadingWords() {
        didStartLoadingWordsCount += 1
    }
    
    var didEndLoadingWordsError: Error?
    var didEndLoadingWordsCount: Int = .zero
    func didEndLoadingWords(error: Error?) {
        didEndLoadingWordsError = error
        didEndLoadingWordsCount += 1
    }
    
    var didSetCurrentWordPair: WordPair?
    var didSetCurrentWordPairCount: Int = .zero
    func didSetCurrentWordPair(_ pair: TranslateChecker.WordPair?) {
        didSetCurrentWordPair = pair
        didSetCurrentWordPairCount += 1
    }
    
    
}
