//
//  LoggedInInteractor.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func cleanupViews()
    func routeToTodoDetail()
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    init(mutableTodoStream: MutableTodoStream) {
        self.mutableTodoStream = mutableTodoStream
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
    }

    // MARK: - Private

    private let mutableTodoStream: MutableTodoStream
}

extension LoggedInInteractor {
    func routToDetailTodo() {
        router?.routeToTodoDetail()
    }
}
