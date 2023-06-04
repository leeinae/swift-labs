//
//  RootRouter.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/03.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // view hierarchy를 조절하기 위해 router가 호출하는 메소드 정의
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>,
    RootRouting
{
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOut: ViewableRouting?

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loggedOutBuilder: LoggedOutBuildable
    ) {
        self.loggedOutBuilder = loggedOutBuilder
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
}
