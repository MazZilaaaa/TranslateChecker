import XCTest
@testable import TranslateChecker

final class TrainingWordsViewModelTests: XCTestCase {
    private var viewModel: TrainingWordsViewModelImp!
    private var game: TrainingWordGameMock!
    
    override func setUp() {
        super.setUp()
        
        game = TrainingWordGameMock()
        viewModel = TrainingWordsViewModelImp(game: game)
    }
    
    func test_willAppear() {
        // when
        viewModel.willAppear()
        
        // then
        XCTAssertEqual(game.startCount, 1)
    }
    
    func  test_didTapWrong() {
        // when
        viewModel.didTapWrong()
        
        // then
        XCTAssertEqual(game.checkRoundStatus, .incorrect)
    }
    
    func  test_didTapCorrect() {
        // when
        viewModel.didTapCorrect()
        
        // then
        XCTAssertEqual(game.checkRoundStatus, .correct)
    }
    
    func test_setWordsCountForTrainig() {
        // when
        viewModel.setWordsCountForTrainig(1)
        
        // then
        XCTAssertEqual(game.setWordsCount, 1)
    }
}
