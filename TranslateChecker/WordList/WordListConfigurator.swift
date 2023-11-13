import UIKit

public typealias WordListModule = (controller: UIViewController, input: WordListInput)

final class WordListConfigurator {
    func configure(output: WordListOutput? = nil) -> WordListModule {
        let presenter = WordListPresenter(output: output, wordListService: getWordsService())
        let vc = WordListViewController()
        
        return (vc, presenter)
    }
    
    func getWordsService() -> WordListFileService {
        let wordsURL = Bundle.main.url(forResource: "words", withExtension: "json")!
        return WordListFileService(wordFileURL: wordsURL, fileReader: DefaultFileReader())
    }
}
