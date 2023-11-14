import SwiftUI

struct DashboardView<ViewModelType: DashboardViewModel>: View {
    @StateObject var viewModel: ViewModelType
    
    var body: some View {
        VStack {
            Spacer()
            actions
        }
    }
    
    var actions: some View {
        HStack(spacing: 16) {
            Button("Start training words") {
                viewModel.trainingDidTap()
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModelMock())
    }
    
    private final class DashboardViewModelMock: DashboardViewModel {
        func showAllWordsDidTap() {
        }
        
        func trainingDidTap() {
        }
    }

}

