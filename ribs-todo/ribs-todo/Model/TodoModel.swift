//
//  TodoModel.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/25.
//

import Foundation
import RxSwift
import RxCocoa

struct TodoModel {
    let title: String
    let description: String
}

protocol TodoStream: AnyObject {
    var todo: Observable<TodoModel> { get }
}

protocol MutableTodoStream: TodoStream {
    func updateTodo(with todo: TodoModel)
}

final class TodoStreamImpl: MutableTodoStream {
    private let variable = BehaviorRelay(value: TodoModel(title: "", description: ""))

    var todo: Observable<TodoModel> {
        variable.asObservable()
    }

    func updateTodo(with todo: TodoModel) {
        let newTodo: TodoModel = .init(
            title: todo.title,
            description: todo.description)
        variable.accept(newTodo)
    }
}
