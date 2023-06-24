//
//  DetailTodoRouter.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/25.
//

import RIBs

protocol DetailTodoInteractable: Interactable {
    var router: DetailTodoRouting? { get set }
    var listener: DetailTodoListener? { get set }
}

protocol DetailTodoViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DetailTodoRouter: ViewableRouter<DetailTodoInteractable, DetailTodoViewControllable>, DetailTodoRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DetailTodoInteractable, viewController: DetailTodoViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
