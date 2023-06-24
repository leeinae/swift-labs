//
//  LoggedInRouter.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

protocol LoggedInInteractable: Interactable, TodoListener {
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
        todoBuilder: TodoBuildable
    ) {
        self.viewController = viewController
        self.todoBuilder = todoBuilder
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

    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let todoBuilder: TodoBuildable
    private var currentChild: ViewableRouting?

    private func routeToTodo() {
        let router = todoBuilder.build(withListener: interactor)
        attachChild(router)
        currentChild = router
        viewController.present(viewController: router.viewControllable)
    }
}
