import Foundation

protocol TrainingWordsGameOutput: AnyObject {
    func didFinishGame(with score: TrainingWordsGameScore)
    func didChangeScore(_ score: TrainingWordsGameScore)
    func didStartLoadingWords()
    func didEndLoadingWords(error: Error?)
    func didSetCurrentWordPair(_ pair: WordPair?)
}

protocol TrainingWordsGameProtocol {
    func setWordsCount(_ count: Int)
    func setRoundTime(_ time: TimeInterval)
    func start()
    func checkRound(with status: WordPairTranslationStatus?)
}

final class TrainingWordsGame {
    private let wordsService: WordListService
    private let wordsPairGenerator: WordPairGenerator
    
    weak var output: TrainingWordsGameOutput?
    
    private var wordPairs: [WordPair] = []
    private var currentWordPair: WordPair?
    private var lastResponse: WordListResponse?
    private var wordsCount: Int = .zero
    private var wordsOffset: Int  = .zero
    private var correctAttemptsCount: Int =  .zero
    private var wrongAttemptsCount: Int =  .zero
    private var timer: Timer?
    private var roundTime: TimeInterval = 5
    
    init(wordsService: WordListService, wordsPairGenerator: WordPairGenerator) {
        self.wordsService = wordsService
        self.wordsPairGenerator = wordsPairGenerator
    }
    
    private func start(wordsCount: Int, fromOffset: Int) {
        correctAttemptsCount = .zero
        wrongAttemptsCount = .zero
        output?.didChangeScore(TrainingWordsGameScore(wrongAttempts: wrongAttemptsCount, correctAttempts: correctAttemptsCount))
        output?.didStartLoadingWords()
        wordsService.getList(offset: fromOffset, size: wordsCount) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handle(response: response)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
    private func nextRound() {
        timer?.invalidate()
        guard wordPairs.count > 0 else {
            finish()
            return
        }
        
        currentWordPair = wordPairs.removeFirst()
        output?.didSetCurrentWordPair(currentWordPair)
        startTimer()
    }
    
    private func finish() {
        output?.didFinishGame(with: TrainingWordsGameScore(wrongAttempts: wrongAttemptsCount, correctAttempts: correctAttemptsCount))
    }
    
    private func startTimer() {
        self.timer?.invalidate()
        let timer = Timer(timeInterval: roundTime, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: false)
        RunLoop.current.add(timer, forMode: .common)
        self.timer = timer
    }
    
    @objc private func handleTimer() {
        checkRound(with: nil)
    }
    
    private func handle(response: WordListResponse) {
        lastResponse = response
        wordsOffset = response.offset + response.totalCount
        wordPairs = wordsPairGenerator.generate(from: response.words, correctTranslations: 0.25)
        nextRound()
        startTimer()
        output?.didEndLoadingWords(error: nil)
    }
    
    private func handle(error: Error) {
        output?.didEndLoadingWords(error: error)
    }
}

extension TrainingWordsGame: TrainingWordsGameProtocol {
    func setWordsCount(_ count: Int) {
        wordsCount = count
    }
    
    func setRoundTime(_ time: TimeInterval) {
        roundTime = time
    }
    
    func start() {
        start(wordsCount: wordsCount, fromOffset: lastResponse?.hasMore == true ? wordsOffset : .zero)
    }
    
    func checkRound(with status: WordPairTranslationStatus?) {
        if currentWordPair?.translationStatus == status {
            correctAttemptsCount += 1
        } else {
            wrongAttemptsCount += 1
        }
        
        output?.didChangeScore(TrainingWordsGameScore(wrongAttempts: wrongAttemptsCount, correctAttempts: correctAttemptsCount))
        
        nextRound()
    }
}
