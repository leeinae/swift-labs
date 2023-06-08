//
//  RootComponent+LoggedIn.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/08.
//

import RIBs

/// RootDependency가 이 프로토콜을 준수해야함
/// LoggedIn scope에 제공하기 위해 Root의 부모 scpe에서 필요한 dependency들 ..
protocol RootDependencyLoggedIn: Dependency {}

extension RootComponent: LoggedInDependency {
    var loggedInViewController: LoggedInViewControllable {
        return rootViewController
    }
}
