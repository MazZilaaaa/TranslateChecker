import UIKit

final class WordListConfigurator {
    
    func getWordsService() -> WordListFileService {
        let wordsURL = Bundle.main.url(forResource: "words", withExtension: "json")!
        return WordListFileService(wordFileURL: wordsURL, fileReader: DefaultFileReader())
    }
}
