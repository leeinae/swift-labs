//
//  LoggedInBuilder.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

protocol LoggedInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var loggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency> {
    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var LoggedInViewController: LoggedInViewControllable {
        dependency.loggedInViewController
    }

    let username: String?

    init(dependency: LoggedInDependency, username: String?) {
        self.username = username
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener, username: String?) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {
    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener, username: String?) -> LoggedInRouting {
        let component = LoggedInComponent(
            dependency: dependency,
            username: username
        )
        let interactor = LoggedInInteractor()
        interactor.listener = listener

        let todoBuilder = TodoBuilder(dependency: component)

        return LoggedInRouter(
            interactor: interactor,
            viewController: component.LoggedInViewController,
            todoBuilder: todoBuilder
        )
    }
}
