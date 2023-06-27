//
//  LoggedInRequired.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/27.
//

import Foundation
import RIBs

// MARK: - Static

protocol LoggedInStaticRequired {
    var loggedInViewController: LoggedInViewControllable { get }
}

struct LoggedInStaticRequirment: LoggedInStaticRequired {
    let loggedInViewController: LoggedInViewControllable
}

// MARK: - Dynamic

protocol LoggedInDynamicRequired {
    var username: String? { get }
}

struct LoggedInDynamicRequirement: LoggedInDynamicRequired {
    var username: String?
}

// MARK: - Interactor

protocol LoggedInInteractorRequired {}

struct LoggedInInteractorRequirement: LoggedInInteractorRequired {}

// MARK: - Requirement

protocol LoggedInRequired: LoggedInStaticRequired, LoggedInDynamicRequired, LoggedInInteractorRequired {}

struct LoggedInRequirement: LoggedInRequired {
    var loggedInViewController: LoggedInViewControllable
    var username: String?
}
