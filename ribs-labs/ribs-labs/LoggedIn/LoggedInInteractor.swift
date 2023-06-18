//
//  LoggedInInteractor.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/04.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func routeToGame(with gameBuilder: GameBuildable)
    func routeToOffGame(with game: [Game])
    func cleanupViews()
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    private var currentChild: ViewableRouting?
    private var games = [Game]()

    init(games: [Game]) {
        self.games = games
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        router?.routeToOffGame(with: games)
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }

    // MARK: - OffGameListener

    func startGame(with gameBuilder: GameBuildable) {
        router?.routeToGame(with: gameBuilder)
    }

    // MARK: - TicTacToeListener

//    func ticTacToeDidEnd(with winner: PlayerType?) {
//        router?.routeToOffGame(with: games)
//    }

    // MARK: - GameListener
    func gameDidEnd(with winner: PlayerType?) {
        router?.routeToOffGame(with: games)
    }
}

extension LoggedInInteractor: LoggedInActionableItem {
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, Void)> {
        let game: Game? = games.first { game in
            game.id.lowercased() == id?.lowercased()
        }

        if let game = game {
            router?.routeToGame(with: game.builder)
        }

        return Observable.just((self, ()))
    }
}
