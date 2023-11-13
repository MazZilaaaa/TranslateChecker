protocol WordPairGenerator {
    func generate(from words: [Word], correctTranslations: Float) -> [WordPair]
}

final class WordPairGeneratorImpl: WordPairGenerator {
    func generate(from words: [Word], correctTranslations: Float) -> [WordPair] {
        words.map {
            WordPair(value: $0.value, translation: $0.transaltionSpa, translationStatus: .correct)
        }
    }
}
