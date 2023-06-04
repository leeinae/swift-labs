//
//  AppComponent.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/04.
//

import RIBs

final class AppComponent: Component<EmptyDependency>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
