//
//  SceneDelegate.swift
//  ribs-todo
//
//  Created by inae Lee on 2023/06/24.
//

import UIKit
import RIBs

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter

        launchRouter.launch(from: window)
    }

    private var launchRouter: LaunchRouting?
}
