import SwiftUI

struct TrainingWordsView<ViewModelType: TrainingWordsViewModel>: View {
    @StateObject var viewModel: ViewModelType
    
    var body: some View {
        VStack(alignment: .trailing) {
            score.frame(alignment: .topTrailing)
            ZStack {
                Color.clear
                VStack {
                    currentWord
                    translatedWord
                }
                VStack {
                    Spacer()
                    actions
                }
            }
        }
        .padding(16)
        .onAppear {
            viewModel.willAppear()
        }
    }
    
    var score: some View {
        VStack {
            Text("Correct attempts ") + Text("\(viewModel.correctAttemptsCount)")
            Text("Wrong attempts ") + Text(" \(viewModel.wrongAttemptsCount)")
        }
    }
    
    var currentWord: some View {
        Text(viewModel.currentWordPair?.value ?? "")
    }
    
    var translatedWord: some View {
        Text(viewModel.currentWordPair?.translation ?? "")
    }
    
    var actions: some View {
        HStack(spacing: 16) {
            Button {
                viewModel.didTapWrong()
            } label: {
                Text("Wrong")
                    .foregroundColor(.white)
                    .padding(8)
                    .background {
                        Color.red.cornerRadius(8)
                    }
            }
            
            Button {
                viewModel.didTapCorrect()
            } label: {
                Text("Correct")
                    .foregroundColor(.white)
                    .padding(8)
                    .background {
                        Color.green.cornerRadius(8)
                    }
            }
        }
    }
}

struct TrainingWordsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingWordsView(viewModel: TrainingWordsViewModelMock())
    }
    
    private final class TrainingWordsViewModelMock: TrainingWordsViewModel {
        var currentWordPair: WordPair?
        @Published var isLoading: Bool = false
        @Published var correctAttemptsCount: Int = 10
        @Published var wrongAttemptsCount: Int =  3
        
        func willAppear() {
        }
        
        func didTapWrong() {
            wrongAttemptsCount += 1
        }
        
        func didTapCorrect() {
            correctAttemptsCount += 1
        }
        
        func setWordsCountForTrainig(_ count: Int) {
        }
    }
}
