//
//  DetailTodoInteractor.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/25.
//

import RIBs
import RxSwift

protocol DetailTodoRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DetailTodoPresentable: Presentable {
    var listener: DetailTodoPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DetailTodoListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DetailTodoInteractor: PresentableInteractor<DetailTodoPresentable>, DetailTodoInteractable, DetailTodoPresentableListener {

    weak var router: DetailTodoRouting?
    weak var listener: DetailTodoListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DetailTodoPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
