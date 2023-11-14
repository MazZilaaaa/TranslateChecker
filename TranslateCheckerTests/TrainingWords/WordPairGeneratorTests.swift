import XCTest
@testable import TranslateChecker

final class WordPairGeneratorTests: XCTestCase {
    private var wordsGenerator: WordPairGenerator!
    
    override func setUp() {
        super.setUp()
        
        wordsGenerator = WordPairGeneratorImpl()
    }
    
    func test_allCorrected() {
        // given
        
        // when
        let pairs = wordsGenerator.generate(from: Word.tenWords(), correctTranslations: 1)
        
        // then
        XCTAssertTrue(pairs.allSatisfy { $0.translationStatus == .correct })
    }
    
    func test_allIncorrected() {
        // given
        
        // when
        let pairs = wordsGenerator.generate(from: Word.tenWords(), correctTranslations: 0)
        
        // then
        XCTAssertTrue(pairs.allSatisfy { $0.translationStatus == .incorrect })
    }
    
    func test_25Corrected() {
        // given
        let totalWords = Word.tenWords()
        let correctedWordsPercentage: Float = 0.25
        
        // when
        let pairs = wordsGenerator.generate(from: totalWords, correctTranslations: correctedWordsPercentage)
        
        // then
        let correctedPairs = pairs.filter { $0.translationStatus  == .correct }
        let incorrectedPairs = pairs.filter { $0.translationStatus  == .incorrect }
        XCTAssertEqual(correctedPairs.count, 2)
        XCTAssertEqual(incorrectedPairs.count, 8)
    }
}
