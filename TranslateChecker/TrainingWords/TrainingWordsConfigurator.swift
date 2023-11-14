import UIKit
import SwiftUI

typealias TrainingWordsModule = (controller: UIViewController, input: TrainingWordsInput)

final class TrainingWordsConfigurator {
    func configure(wordsCountForTraining: Int, output: TrainingWordsOutput? = nil) -> TrainingWordsModule {
        let game = TrainingWordsGame(
            wordsService: WordListConfigurator().getWordsService(),
            wordsPairGenerator: WordPairGeneratorImpl()
        )
        
        let viewModel = TrainingWordsViewModelImp(game: game)
        
        game.output = viewModel
        viewModel.setWordsCountForTrainig(wordsCountForTraining)
        viewModel.output = output
        let view = TrainingWordsView(viewModel: viewModel)
        let  controller = UIHostingController(rootView: view)
        
        return (controller, viewModel)
    }
}
