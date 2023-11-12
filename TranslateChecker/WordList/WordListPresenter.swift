final class WordListPresenter {
    weak var output: WordListOutput?
    private let wordListService: WordListService
    
    init(
        output: WordListOutput? = nil,
        wordListService: WordListService
    ) {
        self.output = output
        self.wordListService = wordListService
    }
}

extension WordListPresenter: WordListInput {
    
}
