import UIKit

public typealias WordListModule = (controller: UIViewController, input: WordListInput)

final class WordListConfigurator {
    func configure(output: WordListOutput? = nil) -> WordListModule {
        let wordsURL = Bundle.main.url(forResource: "words", withExtension: "json")!
        let wordListService = WordListFileService(wordFileURL: wordsURL, fileReader: DefaultFileReader())
        let presenter = WordListPresenter(output: output, wordListService: wordListService)
        let vc = WordListViewController()
        
        return (vc, presenter)
    }
}
