//
//  TodoRouter.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

protocol TodoInteractable: Interactable {
    var router: TodoRouting? { get set }
    var listener: TodoListener? { get set }
}

protocol TodoViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TodoRouter: ViewableRouter<TodoInteractable, TodoViewControllable>, TodoRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TodoInteractable, viewController: TodoViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
