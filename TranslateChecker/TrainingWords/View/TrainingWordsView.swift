import SwiftUI

struct TrainingWordsView<ViewModelType: TrainingWordsViewModel>: View {
    @StateObject var viewModel: ViewModelType
    @State private var animating: Bool = false
    
    var body: some View {
        ZStack {
            content
                .padding(16)
            if viewModel.isLoading  {
                loadingView
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            viewModel.willAppear()
        }
        .onChange(of: viewModel.currentWordPair) { newValue in
            animating = false
            withAnimation(.linear(duration: viewModel.roundTime)) {
                animating = true
            }
        }
    }
    
    var loadingView: some View {
        ZStack {
            Color.gray.opacity(0.4)
            ProgressView()
        }
    }
    
    var content: some View {
        VStack(alignment: .trailing) {
            score.frame(alignment: .topTrailing)
            ZStack {
                Color.clear
                VStack(spacing: 8) {
                    currentWord
                    translatedWord
                        .offset(y: animating ? 240 : 0)
                    Divider()
                        .frame(height: 1)
                        .overlay {
                            Color.red
                        }
                        .padding(.top, 200)
                        
                }
                VStack {
                    Spacer()
                    actions
                }
            }
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
        var roundTime: TimeInterval = 0.0
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
        
        func setRoundTime(_ time: TimeInterval) {
        }
    }
}
