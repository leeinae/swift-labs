//
//  TodoBuilder.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

protocol TodoDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var inputUsername: String { get }
    var mutableTodoStream: MutableTodoStream { get }
}

final class TodoComponent: Component<TodoDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    fileprivate var inputUsername: String {
        dependency.inputUsername
    }

    fileprivate var mutableTodoStream: MutableTodoStream {
        dependency.mutableTodoStream
    }
}

// MARK: - Builder

protocol TodoBuildable: Buildable {
    func build(withListener listener: TodoListener) -> TodoRouting
}

final class TodoBuilder: Builder<TodoDependency>, TodoBuildable {
    override init(dependency: TodoDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TodoListener) -> TodoRouting {
        let component = TodoComponent(dependency: dependency)
        let viewController = TodoViewController(username: component.inputUsername)
        let interactor = TodoInteractor(
            presenter: viewController,
            mutableTodoStream: component.mutableTodoStream
        )
        interactor.listener = listener
        return TodoRouter(interactor: interactor, viewController: viewController)
    }
}
