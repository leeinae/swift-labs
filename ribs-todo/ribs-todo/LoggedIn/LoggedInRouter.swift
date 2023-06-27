//
//  LoggedInRouter.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

protocol LoggedInInteractable: Interactable, TodoListener, DetailTodoListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    init(
        interactor: LoggedInInteractable,
        viewController: LoggedInViewControllable,
        todoBuilder: TodoBuildable,
        detailTodoBuilder: DetailTodoBuildable
    ) {
        self.viewController = viewController
        self.todoBuilder = todoBuilder
        self.detailTodoBuilder = detailTodoBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        routeToTodo()
    }

    func cleanupViews() {
        if let currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }

    func routeToTodoDetail() {
        detachCurrenChild()

        let detailTodo = detailTodoBuilder.build(withListener: interactor)
        attachChild(detailTodo)
        viewController.present(viewController: detailTodo.viewControllable)
    }

    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let todoBuilder: TodoBuildable
    private let detailTodoBuilder: DetailTodoBuildable
    private var currentChild: ViewableRouting?

    private func routeToTodo() {
        let router = todoBuilder.build(withListener: interactor, requirement: TodoDynamicRequirement())
        attachChild(router)
        currentChild = router
        viewController.present(viewController: router.viewControllable)
    }

    private func detachCurrenChild() {
        if let currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
}
