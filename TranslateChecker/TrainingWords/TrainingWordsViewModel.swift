import Foundation

protocol TrainingWordsViewModel: ObservableObject {
    var isLoading: Bool { get }
    var roundTime: TimeInterval { get }
    var currentWordPair: WordPair? { get }
    var correctAttemptsCount: Int { get }
    var wrongAttemptsCount: Int { get }
    func willAppear()
    func didTapWrong()
    func didTapCorrect()
    func setWordsCountForTrainig(_ count: Int)
    func setRoundTime(_ time: TimeInterval)
}

final class TrainingWordsViewModelImp {
    private let game: TrainingWordsGameProtocol
    weak var output: TrainingWordsOutput?
    
    @Published var isLoading: Bool = false
    @Published var roundTime: TimeInterval = 5
    @Published var currentWordPair: WordPair?
    @Published var correctAttemptsCount: Int =  .zero
    @Published var wrongAttemptsCount: Int =  .zero
    
    public init(game: TrainingWordsGameProtocol) {
        self.game = game
    }
}

extension TrainingWordsViewModelImp: TrainingWordsViewModel {
    func willAppear() {
        game.start()
    }
    
    func didTapWrong() {
        game.checkRound(with: .incorrect)
    }
    
    func didTapCorrect() {
        game.checkRound(with: .correct)
    }
    
    func setWordsCountForTrainig(_ count: Int) {
        game.setWordsCount(count)
    }
    
    func setRoundTime(_ time: TimeInterval) {
        game.setRoundTime(time)
        roundTime = time
    }
}

extension TrainingWordsViewModelImp: TrainingWordsInput {
    func restart() {
        game.start()
    }
}

extension TrainingWordsViewModelImp: TrainingWordsGameOutput {
    func  didSetCurrentWordPair(_ pair: WordPair?) {
        currentWordPair = pair
    }
    
    func didChangeScore(_ score: TrainingWordsGameScore) {
        correctAttemptsCount = score.correctAttempts
        wrongAttemptsCount = score.wrongAttempts
    }
    
    func didFinishGame(with score: TrainingWordsGameScore) {
        output?.didFinishGame(with: score)
    }
    
    func didStartLoadingWords() {
        isLoading = true
    }
    
    func didEndLoadingWords(error: Error?) {
        isLoading =  false
        if let error = error {
            // show error
        }
    }
}
