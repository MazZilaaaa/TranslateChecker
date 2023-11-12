import XCTest
@testable import TranslateChecker

final class DefaultFileReaderTests: XCTestCase {
    private var reader: DefaultFileReader!
    
    override func setUp() {
        super.setUp()
        
        reader = DefaultFileReader()
    }
    
    func test_multithreading() {
        // will not provide testing this part of code
    }
}
