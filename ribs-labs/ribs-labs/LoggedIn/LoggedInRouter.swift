//
//  LoggedInRouter.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/04.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener, GameListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

/// viewless한 RIB을 생성할 때는 해당 RIB이 detach될 때 사용할 수 있는 hook을 제공한다.
protocol LoggedInViewControllable: ViewControllable {
//    func present(viewController: ViewControllable)
//    func dismiss(viewController: ViewControllable)
    func replaceModal(viewController: ViewControllable?)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable
    private let ticTacToeBuilder: TicTacToeBuildable
    private var currentChild: ViewableRouting?

    init(
        interactor: LoggedInInteractable,
        viewController: LoggedInViewControllable,
        offGameBuilder: OffGameBuildable,
        ticTacToeBuilder: TicTacToeBuildable
    ) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    /// 부모 RIB이 LoggedIn RIB을 detach하려고 할 때, LoggedInInteractor에 의해 호출됨
    func cleanupViews() {
        if currentChild != nil {
            viewController.replaceModal(viewController: nil)
        }
    }

    func routeToOffGame(with game: [Game]) {
        detachCurrentChild()
        attachOffGame(with: game)
    }

    func routeToGame(with gameBuilder: GameBuildable) {
        detachCurrentChild()

        let game = gameBuilder.build(withListener: interactor)
        currentChild = game
        attachChild(game)
        viewController.replaceModal(viewController: game.viewControllable)
    }

    private func attachOffGame(with games: [Game]) {
        let offGame = offGameBuilder.build(withListener: interactor, games: games)
        currentChild = offGame
        attachChild(offGame)
        viewController.replaceModal(viewController: offGame.viewControllable)
    }

    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.replaceModal(viewController: nil)
        }
    }
}
