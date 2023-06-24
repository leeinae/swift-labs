//
//  LoggedInComponent+Todo.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import Foundation

extension LoggedInComponent: TodoDependency {
    var inputUsername: String {
        username ?? "NOT USER"
    }
}
