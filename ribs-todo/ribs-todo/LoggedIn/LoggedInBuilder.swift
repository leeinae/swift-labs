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

    init(dependency: LoggedInDependency, username: String?) {
        self.username = username
        super.init(dependency: dependency)
    }

    var mutableTodoStream: MutableTodoStream {
        shared {
            TodoStreamImpl()
        }
    }

    let username: String?

    fileprivate var loggedInViewController: LoggedInViewControllable {
        dependency.loggedInViewController
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
        let interactor = LoggedInInteractor(mutableTodoStream: component.mutableTodoStream)
        interactor.listener = listener

        let todoBuilder = TodoBuilder(dependency: component)
        let detailTodoBuilder = DetailTodoBuilder(dependency: component)

        return LoggedInRouter(
            interactor: interactor,
            viewController: component.loggedInViewController,
            todoBuilder: todoBuilder,
            detailTodoBuilder: detailTodoBuilder
        )
    }
}
