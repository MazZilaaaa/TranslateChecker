enum WordPairTranslationStatus {
    case correct
    case incorrect
}

struct WordPair {
    let value: String
    let translation: String
    let translationStatus: WordPairTranslationStatus
}
