import SwiftUI

struct DashboardView<ViewModelType: DashboardViewModel>: View {
    @StateObject var viewModel: ViewModelType
    @State private var roundTime: Int = 5
    @State private var wordsCount: Int = 15
    
    var body: some View {
        VStack {
            Form {
                Picker(selection: $roundTime, label: Text("Select round time")) {
                    ForEach([5, 3, 2, 1], id: \.self) { value in
                        Text("\(value)")
                    }
                }
                Picker(selection: $wordsCount, label: Text("Select words count")) {
                    ForEach([5,  15, 30], id: \.self) { value in
                        Text("\(value)")
                    }
                }
            }
            Spacer()
            actions
        }
    }
    
    var actions: some View {
        HStack(spacing: 16) {
            Button("Start training words") {
                viewModel.trainingDidTap(wordsCount: wordsCount, roundTime: TimeInterval(roundTime))
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModelMock())
    }
    
    private final class DashboardViewModelMock: DashboardViewModel {
        func trainingDidTap(wordsCount: Int, roundTime: TimeInterval) {
        }
    }

}

