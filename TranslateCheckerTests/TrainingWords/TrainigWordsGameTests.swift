import XCTest
@testable import TranslateChecker

enum TrainingWordsGameTestsError: Error, Equatable {
    case test
}

final class TrainingWordsGameTests: XCTestCase {
    private var game: TrainingWordsGame!
    private var wordsService: WordsListServiceMock!
    private var wordsGenerator: WordsPairGeneratorMock!
    private var output: TrainingWordsGameOutputMock!
    
    override func setUp() {
        super.setUp()
        
        wordsService = WordsListServiceMock()
        wordsGenerator = WordsPairGeneratorMock()
        output = TrainingWordsGameOutputMock()
        
        game = TrainingWordsGame(wordsService: wordsService, wordsPairGenerator: wordsGenerator)
        game.output = output
    }
    
    func test_start() {
        // given
        wordsService.result = .success(.stub())
        let pairs = Word.tenWords().map { WordPair(value: $0.value, translation: $0.transaltionSpa, translationStatus: .correct) }
        wordsGenerator.generateOutput = pairs
        
        // when
        game.start()
        
        // then
        XCTAssertEqual(output.didChangeScore?.wrongAttempts, .zero)
        XCTAssertEqual(output.didChangeScore?.correctAttempts, .zero)
        XCTAssertEqual(output.didStartLoadingWordsCount, 1)
        XCTAssertEqual(output.didEndLoadingWordsCount, 1)
        XCTAssertNil(output.didEndLoadingWordsError)
        XCTAssertEqual(output.didSetCurrentWordPair, pairs.first)
    }
    
    func test_startError() {
        // given
        wordsService.result = .failure(TrainingWordsGameTestsError.test)
        
        // when
        game.start()
        
        // then
        XCTAssertEqual(output.didChangeScore?.wrongAttempts, .zero)
        XCTAssertEqual(output.didChangeScore?.correctAttempts, .zero)
        XCTAssertEqual(output.didStartLoadingWordsCount, 1)
        XCTAssertEqual(output.didEndLoadingWordsCount, 1)
        XCTAssertEqual(output.didEndLoadingWordsError as? TrainingWordsGameTestsError, TrainingWordsGameTestsError.test)
        XCTAssertNil(output.didSetCurrentWordPair)
    }
    
    func test_checkRound_correctAttempt() {
        // given
        wordsService.result = .success(.stub())
        let pairs = Word.tenWords().map { WordPair(value: $0.value, translation: $0.transaltionSpa, translationStatus: .correct) }
        wordsGenerator.generateOutput = pairs
        game.start()
        
        // when
        game.checkRound(with: .correct)
        
        // then
        XCTAssertEqual(output.didChangeScore?.correctAttempts, 1)
        XCTAssertEqual(output.didChangeScore?.wrongAttempts, .zero)
        XCTAssertEqual(output.didSetCurrentWordPairCount, 2)
        XCTAssertEqual(output.didSetCurrentWordPair, pairs.dropFirst().first)
    }
    
    func test_checkRound_incorrectAttempt() {
        // given
        wordsService.result = .success(.stub())
        let pairs = Word.tenWords().map { WordPair(value: $0.value, translation: $0.transaltionSpa, translationStatus: .correct) }
        wordsGenerator.generateOutput = pairs
        game.start()
        
        // when
        game.checkRound(with: .incorrect)
        
        // then
        XCTAssertEqual(output.didChangeScore?.correctAttempts, .zero)
        XCTAssertEqual(output.didChangeScore?.wrongAttempts, 1)
        XCTAssertEqual(output.didSetCurrentWordPairCount, 2)
        XCTAssertEqual(output.didSetCurrentWordPair, pairs.dropFirst().first)
    }
}
