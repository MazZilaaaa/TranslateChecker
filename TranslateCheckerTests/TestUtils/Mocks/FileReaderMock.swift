import Foundation
@testable import TranslateChecker

final class FileReaderMock: FileReader {
    var completionResult: Result<Data, Error>!
    var readFileURL: URL?
    func read(fileURL: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        readFileURL = fileURL
        completion(completionResult)
    }
}
