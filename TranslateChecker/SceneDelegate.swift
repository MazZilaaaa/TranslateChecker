import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var dashboardInput: DashboardInput?
    
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
    func trainingDidTap() {
        print("show training module")
    }
    
    func showAllWordsDidTap() {
        let wordsListModule = WordListConfigurator().configure()
        window?.rootViewController?.present(wordsListModule.controller, animated: true)
    }
}

