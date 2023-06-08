//
//  LoggedInBuilder.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/04.
//

import RIBs

protocol LoggedInDependency: Dependency {
    var loggedInViewController: LoggedInViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency> {
    fileprivate var loggedInViewController: LoggedInViewControllable {
        dependency.loggedInViewController
    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {
    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency)
        let interactor = LoggedInInteractor()
        interactor.listener = listener

        let offGameBuilder = OffGameBuilder(dependency: component)
        return LoggedInRouter(
            interactor: interactor,
            viewController: component.loggedInViewController,
            offGameBuilder: offGameBuilder
        )
    }
}
