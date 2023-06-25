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

    func set(todo: TodoModel)
}

protocol DetailTodoListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DetailTodoInteractor: PresentableInteractor<DetailTodoPresentable>, DetailTodoInteractable, DetailTodoPresentableListener {
    weak var router: DetailTodoRouting?
    weak var listener: DetailTodoListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: DetailTodoPresentable, todoStream: TodoStream) {
        self.todoStream = todoStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        updateTodo()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    // MARK: - Private

    private let todoStream: TodoStream

    private func updateTodo() {
        todoStream.todo
            .subscribe { [weak self] in
                self?.presenter.set(todo: $0)
            }
            .disposeOnDeactivate(interactor: self)
    }
}
