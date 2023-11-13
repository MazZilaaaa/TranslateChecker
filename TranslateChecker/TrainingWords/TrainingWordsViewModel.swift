import Foundation

protocol TrainingWordsViewModel: ObservableObject {
    var isLoading: Bool { get }
    var currentWordPair: WordPair? { get }
    var correctAttemptsCount: Int { get }
    var wrongAttemptsCount: Int { get }
    func willAppear()
    func didTapWrong()
    func didTapCorrect()
    func setWordsCountForTrainig(_ count: Int)
    
}

final class TrainingWordsViewModelImp {
    private let wordsService: WordListService
    private let wordPairGenerator: WordPairGenerator
    
    weak var output: TrainingWordsOutput?
    
    @Published var isLoading: Bool = false
    @Published var currentWordPair: WordPair?
    @Published var correctAttemptsCount: Int =  .zero
    @Published var wrongAttemptsCount: Int =  .zero
    
    private var wordsCount: Int = .zero
    private var wordsOffset: Int  = .zero
    private var wordPairs: [WordPair] = []
    private var lastResponse: WordListResponse?
    
    public init(
        wordsService: WordListService,
        wordPairGenerator: WordPairGenerator
    ) {
        self.wordsService = wordsService
        self.wordPairGenerator = wordPairGenerator
    }
    
    private func finish() {
        output?.didFinishGame(with: TrainingWordsGameScore(wrongAttempts: wrongAttemptsCount, correctAttempts: correctAttemptsCount))
    }
    
    private func checkRound(with status: WordPairTranslationStatus) {
        if currentWordPair?.translationStatus == status {
            correctAttemptsCount += 1
        } else {
            wrongAttemptsCount += 1
        }
    }
    
    private func startGame(wordsCount: Int, fromOffset: Int) {
        isLoading = true
        wordsService.getList(offset: fromOffset, size: wordsCount) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let response):
                self?.handle(response: response)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
    private func handle(response: WordListResponse) {
        lastResponse = response
        wordsOffset = response.offset + response.totalCount
        wordPairs = wordPairGenerator.generate(from: response.words, correctTranslations: 0.25)
        nextRound()
    }
    
    private func nextRound() {
        guard wordPairs.count > 0 else {
            finish()
            return
        }
        
        currentWordPair = wordPairs.removeFirst()
    }
    
    private func handle(error: Error) {
        // show error
    }
}

extension TrainingWordsViewModelImp: TrainingWordsViewModel {
    func willAppear() {
    }
    
    func didTapWrong() {
        checkRound(with: .incorrect)
        nextRound()
    }
    
    func didTapCorrect() {
        checkRound(with: .correct)
        nextRound()
    }
    
    func setWordsCountForTrainig(_ count: Int) {
        wordsCount = count
        startGame(wordsCount: count, fromOffset: wordsOffset)
    }
}

extension TrainingWordsViewModelImp: TrainingWordsInput {
    func restart() {
        correctAttemptsCount = .zero
        wrongAttemptsCount = .zero
        startGame(wordsCount: wordsCount, fromOffset: lastResponse?.hasMore == true ? wordsOffset: .zero)
    }
}
