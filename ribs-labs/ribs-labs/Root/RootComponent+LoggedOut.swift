//
//  RootComponent+LoggedOut.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/04.
//

import Foundation

import RIBs

// TODO: Update RootDependency protocol to inherit this protocol.
// LoggedOut scope에 Root scope의 종속성을 제공
protocol RootDependencyLoggedOut: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedOut scope.
}

extension RootComponent: LoggedOutDependency {
    // LoggedOut scope를 제공하기 위해 property를 구현
}
