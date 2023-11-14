import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var dashboardInput: DashboardInput?
    private var trainingWordsInput: TrainingWordsInput?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow()
        window?.windowScene = scene as? UIWindowScene
        let dashboardModule = DashboardConfigurator().configure(output: self)
        self.dashboardInput = dashboardModule.input
        window?.rootViewController = dashboardModule.controller
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: DashboardOutput {
    func trainingDidTap(wordsCount: Int) {
        let module = TrainingWordsConfigurator().configure(wordsCountForTraining: wordsCount, output: self)
        trainingWordsInput = module.input
        
        window?.rootViewController?.present(module.controller, animated: true)
    }
}

extension SceneDelegate: TrainingWordsOutput {
    func didFinishGame(with score: TrainingWordsGameScore) {
        let alert = UIAlertController(
            title: "Your score is",
            message: "correct attempts: \(score.correctAttempts)\nwrong attemtps: \(score.wrongAttempts)",
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "restart game",
                style: .default,
                handler:  { [weak self] _ in
                    self?.trainingWordsInput?.restart()
                }
            )
        )
        
        alert.addAction(
            UIAlertAction(
                title: "done",
                style: .default,
                handler:  { [weak self] _ in
                    self?.window?.rootViewController?.dismiss(animated: true)
                }
            )
        )
        
        window?.rootViewController?.presentedViewController?.present(alert, animated: true)
    }
}

