enum WordPairTranslationStatus {
    case correct
    case incorrect
}

struct WordPair: Equatable {
    let value: String
    let translation: String
    let translationStatus: WordPairTranslationStatus
}
