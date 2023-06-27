//
//  TodoBuilder.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

protocol TodoDependency: Dependency {
    var todoStaticRequirement: TodoStaticRequired { get }
}

final class TodoComponent: Component<TodoDependency> {
    init(dependency: TodoDependency, dynamicRequirement: TodoDynamicRequired) {
        requirement = TodoRequirement(
            mutableTodoStream: dependency.todoStaticRequirement.mutableTodoStream,
            inputUsername: dependency.todoStaticRequirement.inputUsername
        )
        super.init(dependency: dependency)
    }

    fileprivate let requirement: TodoRequirement
}

// MARK: - Builder

protocol TodoBuildable: Buildable {
    func build(withListener listener: TodoListener, requirement: TodoDynamicRequired) -> TodoRouting
}

final class TodoBuilder: Builder<TodoDependency>, TodoBuildable {
    override init(dependency: TodoDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TodoListener, requirement: TodoDynamicRequired) -> TodoRouting {
        let component = TodoComponent(dependency: dependency, dynamicRequirement: requirement)
        let viewController = TodoViewController(username: dependency.todoStaticRequirement.inputUsername)
        let interactor = TodoInteractor(
            presenter: viewController,
            requirement: component.requirement
        )
        interactor.listener = listener
        return TodoRouter(interactor: interactor, viewController: viewController)
    }
}
