@testable import TranslateChecker

final class WordsPairGeneratorMock: WordPairGenerator {
    var words: [Word]?
    var correctTranslations: Float?
    
    var generateOutput: [WordPair]!
    func generate(from words: [Word], correctTranslations: Float) -> [WordPair] {
        self.words = words
        self.correctTranslations = correctTranslations
        
        return generateOutput
    }
}
