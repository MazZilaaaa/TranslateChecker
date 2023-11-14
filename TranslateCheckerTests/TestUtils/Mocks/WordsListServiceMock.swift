@testable import TranslateChecker

final class WordsListServiceMock: WordListService {
    var offset: Int?
    var size: Int?
    var result: Result<WordListResponse, Error>!
    
    func getList(offset: Int, size: Int, completion: @escaping (Result<TranslateChecker.WordListResponse, Error>) -> Void) {
        self.offset = offset
        self.size = size
        completion(result)
    }
}
