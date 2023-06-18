//
//  SceneDelegate.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/03.
//

import RIBs
import UIKit

protocol URLHandler: AnyObject {
    func handle(_ url: URL)
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    private var urlHandler: URLHandler?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let result = RootBuilder(dependency: AppComponent()).build()
        let launchRouter = result.launchRouter

        self.launchRouter = launchRouter
        urlHandler = result.urlHandler
        launchRouter.launch(from: window)

        if let urlContext = connectionOptions.urlContexts.first {
            let url = urlContext.url
            urlHandler?.handle(url)
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }

        urlHandler?.handle(url)
    }
}
