//
//  AppComponent.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

final class AppComponent: Component<EmptyDependency>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
