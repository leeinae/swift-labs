//
//  LoggedInRouter.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/04.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuilder
    private var currentChild: ViewableRouting?

    init(
        interactor: LoggedInInteractable,
        viewController: LoggedInViewControllable,
        offGameBuilder: OffGameBuilder
    ) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        attachOffGame()
    }

    func routeToTicTacToe() {
        ///
    }

    func routeToOffGame() {
        detachCurrentChild()
        attachOffGame()
    }

    /// 부모 RIB이 LoggedIn RIB을 detach하려고 할 때, LoggedInInteractor에 의해 호출됨
    func cleanupViews() {
        if let currentChild = currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }

    private func attachOffGame() {
        let offGame = offGameBuilder.build(withListener: interactor)
        currentChild = offGame
        attachChild(offGame)
        viewController.present(viewController: offGame.viewControllable)
    }

    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
}
