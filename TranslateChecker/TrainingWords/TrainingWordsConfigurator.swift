import UIKit
import SwiftUI

typealias TrainingWordsModule = (controller: UIViewController, input: TrainingWordsInput)

final class TrainingWordsConfigurator {
    func configure(wordsCountForTraining: Int, output: TrainingWordsOutput? = nil) -> TrainingWordsModule {
        let viewModel = TrainingWordsViewModelImp(
            wordsService: WordListConfigurator().getWordsService(),
            wordPairGenerator: WordPairGeneratorImpl()
        )
        
        viewModel.setWordsCountForTrainig(wordsCountForTraining)
        viewModel.output = output
        let view = TrainingWordsView(viewModel: viewModel)
        let  controller = UIHostingController(rootView: view)
        
        return (controller, viewModel)
    }
}
