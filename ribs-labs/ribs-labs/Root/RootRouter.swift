//
//  RootRouter.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/03.
//

import RIBs

/// LoggedIn RIB의 event를 받기 위해, LoggedIn RIB의 listener로써 interactor를 구성한다.
/// Root RIB이 Child (LoggedOut, LoggedIn) Builder를 구성할 때 interactor를 listener로 전달하기 때문에, Listener protocol을 준수해야한다.
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
    private let loggedInBuilder: LoggedInBuildable
    private var loggedOut: ViewableRouting?

    /// 새로운 RIB을 연결하려면, router가 build 할 수 있어야 한다.
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loggedOutBuilder: LoggedOutBuildable,
        loggedInBuilder: LoggedInBuildable
    ) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
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

        routeToLoggedOut()
    }
}

// MARK: - RootRouting

extension RootRouter {
    func routeToLoggedIn(player1Name: String, player2Name: String) {
        if let loggedOut = self.loggedOut {
            detachChild(loggedOut)
            viewController.dismiss(viewController: loggedOut.viewControllable)
            self.loggedOut = nil
        }

        let loggedIn = loggedInBuilder.build(withListener: interactor)
        attachChild(loggedIn)
    }

    /// LoggedOut RIB의 리스너로 Root RIB의 interactor 사용
    /// interactor로 전달을 위해, RootInteractable이 LoggedOutListener를 준수해야함
    func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.present(viewController: loggedOut.viewControllable)
    }
}
