//
//  RootComponent+LoggedIn.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import Foundation

extension RootComponent: LoggedInDependency {
    var loggedInStaticRequirement: LoggedInStaticRequired {
        LoggedInStaticRequirment(loggedInViewController: rootViewController)
    }
}
