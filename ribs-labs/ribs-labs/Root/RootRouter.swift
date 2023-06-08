//
//  RootRouter.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/03.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // view hierarchy를 조절하기 위해 router가 호출하는 메소드 정의
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>,
    RootRouting
{
    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedIntBuilder: LoggedInBuildable
    private var loggedOut: ViewableRouting?

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loggedOutBuilder: LoggedOutBuildable,
        loggedInBuilder: LoggedInBuildable
    ) {
        self.loggedOutBuilder = loggedOutBuilder
        loggedIntBuilder = loggedInBuilder
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }

    /// router의 loading이 끝나면 호출됨 (한 번만 호출됨)
    /// 불변 child를 attaching하는 작업처럼 일회성 setup 로직을 구현하려면 서브클래싱해서 override 하삼
    /// 기본 구현은 아무 작업도 하지 않음
    override func didLoad() {
        super.didLoad()

        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.present(viewController: loggedOut.viewControllable)
    }

    func routeToLoggedIn(player1Name: String, player2Name: String) {
        if let loggedOut = self.loggedOut {
            detachChild(loggedOut)
            viewController.dismiss(viewController: loggedOut.viewControllable)
            self.loggedOut = nil
        }

        let loggedIn = loggedIntBuilder.build(withListener: interactor)
        attachChild(loggedIn)
    }
}
