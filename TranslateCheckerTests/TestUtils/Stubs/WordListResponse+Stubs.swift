@testable import TranslateChecker

extension WordListResponse {
    static func stub(
        words: [Word] = Word.tenWords(),
        offset: Int = .zero,
        totalCount: Int = Word.tenWords().count,
        hasMore: Bool = false
    ) -> WordListResponse {
        return WordListResponse(words: words, offset: offset, totalCount: totalCount, hasMore: hasMore)
    }
}
