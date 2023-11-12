import XCTest
@testable import TranslateChecker

final class WordListFileServiceTests: XCTestCase {
    private var service: WordListFileService!
    private var fileReader: FileReaderMock!
    
    override func setUp() {
        super.setUp()
        
        fileReader = FileReaderMock()
        service = WordListFileService(wordFileURL: URL(string: "stub")!, fileReader: fileReader)
    }
    
    func test_getList() {
        // given
        fileReader.completionResult = .success(Word.tenWords())
        
        // when
        let expectation = expectation(description: "test_getList")
        var receivedResult: Result<WordListResponse, Error>?
        service.getList(offset: 0, size: 4) {
            receivedResult = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
        
        // then
        guard case let .success(wordResponse) = receivedResult else {
            XCTFail(".success is expected. Received \(String(describing: receivedResult))")
            return
        }
        
        XCTAssertEqual(wordResponse.offset, 0)
        XCTAssertEqual(wordResponse.totalCount, 4)
        XCTAssertEqual(wordResponse.words.count, 4)
        XCTAssertTrue(wordResponse.hasMore)

        XCTAssertEqual(fileReader.readFileURL, service.wordFileURL)
    }
    
    func test_getList_outOfOffset() {
        // given
        fileReader.completionResult = .success(Word.tenWords())
        
        // when
        let expectation = expectation(description: "test_getList")
        var receivedResult: Result<WordListResponse, Error>?
        service.getList(offset: 11, size: 4) {
            receivedResult = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
        
        // then
        guard case let .success(wordResponse) = receivedResult else {
            XCTFail(".success is expected. Received \(String(describing: receivedResult))")
            return
        }
        
        XCTAssertEqual(wordResponse.offset, 11)
        XCTAssertEqual(wordResponse.totalCount, 0)
        XCTAssertEqual(wordResponse.words.count, 0)
        XCTAssertFalse(wordResponse.hasMore)
    }
    
    func test_getList_outOfSize() {
        // given
        fileReader.completionResult = .success(Word.tenWords())
        
        // when
        let expectation = expectation(description: "test_getList")
        var receivedResult: Result<WordListResponse, Error>?
        service.getList(offset: 1, size: 11) {
            receivedResult = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
        
        // then
        guard case let .success(wordResponse) = receivedResult else {
            XCTFail(".success is expected. Received \(String(describing: receivedResult))")
            return
        }
        
        XCTAssertEqual(wordResponse.totalCount, 9)
        XCTAssertEqual(wordResponse.words.count, 9)
        XCTAssertFalse(wordResponse.hasMore)
    }
}
