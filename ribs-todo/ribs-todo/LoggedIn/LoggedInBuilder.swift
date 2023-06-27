//
//  LoggedInBuilder.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

protocol LoggedInDependency: Dependency {
    var loggedInStaticRequirement: LoggedInStaticRequired { get }
}

final class LoggedInComponent: Component<LoggedInDependency> {
    // TODO: Make sure to convert the variable into lower-camelcase.

    init(dependency: LoggedInDependency, dynamicRequirement: LoggedInDynamicRequired) {
        username = dynamicRequirement.username
        requirement = LoggedInRequirement(loggedInViewController: dependency.loggedInStaticRequirement.loggedInViewController)
        super.init(dependency: dependency)
    }

    var mutableTodoStream: MutableTodoStream {
        shared {
            TodoStreamImpl()
        }
    }

    var username: String?
    fileprivate let requirement: LoggedInRequired
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
            dynamicRequirement: LoggedInDynamicRequirement(username: username)
        )
        let interactor = LoggedInInteractor(mutableTodoStream: component.mutableTodoStream)
        interactor.listener = listener

        let todoBuilder = TodoBuilder(dependency: component)
        let detailTodoBuilder = DetailTodoBuilder(dependency: component)

        return LoggedInRouter(
            interactor: interactor,
            viewController: component.requirement.loggedInViewController,
            todoBuilder: todoBuilder,
            detailTodoBuilder: detailTodoBuilder
        )
    }
}
