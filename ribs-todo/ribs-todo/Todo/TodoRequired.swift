//
//  TodoRequired.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/28.
//

import Foundation

// MARK: - Static

protocol TodoStaticRequired {
    var mutableTodoStream: MutableTodoStream { get }
    var inputUsername: String { get }
}

struct TodoStaticRequirement: TodoStaticRequired {
    var mutableTodoStream: MutableTodoStream
    var inputUsername: String
}

// MARK: - Dynamic

protocol TodoDynamicRequired {}

struct TodoDynamicRequirement: TodoDynamicRequired {}

// MARK: - Interactor

protocol TodoInteractorRequired {
    var mutableTodoStream: MutableTodoStream { get }
}

struct TodoInteractorRequirement: TodoInteractorRequired {
    var mutableTodoStream: MutableTodoStream
}

// MARK: - Required

struct TodoRequirement: TodoStaticRequired, TodoDynamicRequired, TodoInteractorRequired {
    var mutableTodoStream: MutableTodoStream
    var inputUsername: String
}
