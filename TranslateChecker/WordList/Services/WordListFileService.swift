import Foundation

final class WordListFileService {
    let wordFileURL: URL
    let fileReader: FileReader
    let jsonDecoder: JSONDecoder
    
    init(
        wordFileURL: URL,
        fileReader: FileReader,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.wordFileURL = wordFileURL
        self.fileReader = fileReader
        self.jsonDecoder = jsonDecoder
    }
}

extension WordListFileService: WordListService {
    func getList(offset: Int, size: Int, completion: @escaping (Result<WordListResponse, Error>) -> Void) {
        fileReader.read(fileURL: wordFileURL) { [jsonDecoder] result in
            switch result {
            case .success(let data):
                var words: [Word] = []
                do {
                    words = try jsonDecoder.decode([Word].self, from: data)
                } catch {
                    completion(.failure(error))
                    return
                }
                
                guard offset < words.count else {
                    completion(.success(WordListResponse(words: [], offset: offset, totalCount: .zero, hasMore: false)))
                    return
                }
                
                let length = min(size, words.count - offset)
                let response = WordListResponse(
                    words: words.suffix(length),
                    offset: offset,
                    totalCount: length,
                    hasMore: offset < words.count - size
                )
                
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
