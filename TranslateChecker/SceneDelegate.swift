import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var worldListInput: WordListInput?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow()
        window?.windowScene = scene as? UIWindowScene
        let worldListModule = WordListConfigurator().configure(output: self)
        self.worldListInput = worldListModule.input
        window?.rootViewController = worldListModule.controller
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: WordListOutput {
}

