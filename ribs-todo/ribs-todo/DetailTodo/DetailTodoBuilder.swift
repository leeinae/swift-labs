//
//  DetailTodoBuilder.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/25.
//

import RIBs

protocol DetailTodoDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var todoStream: TodoStream { get }
}

final class DetailTodoComponent: Component<DetailTodoDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.

    fileprivate var todoStream: TodoStream {
        dependency.todoStream
    }
}

// MARK: - Builder

protocol DetailTodoBuildable: Buildable {
    func build(withListener listener: DetailTodoListener) -> DetailTodoRouting
}

final class DetailTodoBuilder: Builder<DetailTodoDependency>, DetailTodoBuildable {
    override init(dependency: DetailTodoDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DetailTodoListener) -> DetailTodoRouting {
        let component = DetailTodoComponent(dependency: dependency)
        let viewController = DetailTodoViewController()
        let interactor = DetailTodoInteractor(
            presenter: viewController,
            todoStream: component.todoStream
        )
        interactor.listener = listener
        return DetailTodoRouter(interactor: interactor, viewController: viewController)
    }
}
