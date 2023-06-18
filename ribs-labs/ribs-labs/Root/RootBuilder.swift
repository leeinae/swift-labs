//
//  RootBuilder.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/03.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
    let rootViewController: RootViewController

    init(
        dependency: RootDependency,
        rootViewController: RootViewController
    ) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler)
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler) {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)

        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        let loggedinBuilder = LoggedInBuilder(dependency: component)

        let router = RootRouter(
            interactor: interactor,
            viewController: viewController,
            loggedOutBuilder: loggedOutBuilder,
            loggedInBuilder: loggedinBuilder
        )
        
        return (router, interactor)
    }
}
