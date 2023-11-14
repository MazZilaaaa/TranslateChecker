protocol WordPairGenerator {
    func generate(from words: [Word], correctTranslations: Float) -> [WordPair]
}

final class WordPairGeneratorImpl: WordPairGenerator {
    func generate(from words: [Word], correctTranslations: Float) -> [WordPair] {
        let words = words.shuffled()
        let correctedWordsCount = Int(Float(words.count) * correctTranslations)
        let incorrectWordsCount = words.count - correctedWordsCount
        
        let values = words.suffix(incorrectWordsCount).map { $0.value }.shuffled()
        let spaValues = words.suffix(incorrectWordsCount).map { $0.transaltionSpa }.shuffled()
        var wordsPairs: [WordPair] = []
        for i in 0..<values.count {
            wordsPairs.append(
                WordPair(
                    value: values[i],
                    translation: spaValues[i],
                    translationStatus: .incorrect
                )
            )
        }
        
        let correctedWordPairs = Array(words.prefix(correctedWordsCount)).map { WordPair(value: $0.value, translation: $0.transaltionSpa, translationStatus: .correct) }
        
        return (correctedWordPairs  + wordsPairs).shuffled()
    }
}
