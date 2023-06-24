//
//  RootBuilder.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(
            dependency: dependency,
            rootViewController: viewController
        )
        let interactor = RootInteractor(presenter: viewController)

        let loggedOut = LoggedOutBuilder(dependency: component)
        let loggedIn = LoggedInBuilder(dependency: component)

        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            loggedOutBuilder: loggedOut,
            loggedInBuilder: loggedIn
        )
    }
}
