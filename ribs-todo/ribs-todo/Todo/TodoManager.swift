//
//  UserDefaultManager.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/25.
//

import Foundation

@propertyWrapper
private struct UserDefaultWrapper<T> {
    private let key: String
    private let value: T

    init(key: String, value: T) {
        self.key = key
        self.value = value
    }

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? value
        }

        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct TodoManager {
    @UserDefaultWrapper(key: "todo", value: [String]())
    static var todoList

    @UserDefaultWrapper(key: "description", value: [String]())
    static var detail
}
