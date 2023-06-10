//
//  LoggedInBuilder.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/04.
//

import RIBs

protocol LoggedInDependency: Dependency {
    var loggedInViewController: LoggedInViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency> {
    let player1Name: String
    let player2Name: String

    fileprivate var loggedInViewController: LoggedInViewControllable {
        dependency.loggedInViewController
    }

    init(dependency: LoggedInDependency, player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(
        withListener listener: LoggedInListener,
        player1Name: String,
        player2Name: String
    ) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {
    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: LoggedInListener,
        player1Name: String,
        player2Name: String
    ) -> LoggedInRouting {
        let component = LoggedInComponent(
            dependency: dependency,
            player1Name: player1Name,
            player2Name: player2Name
        )
        let interactor = LoggedInInteractor()
        interactor.listener = listener

        let offGameBuilder = OffGameBuilder(dependency: component)
        let ticTacToeBuilder = TicTacToeBuilder(dependency: component)
        return LoggedInRouter(
            interactor: interactor,
            viewController: component.loggedInViewController,
            offGameBuilder: offGameBuilder,
            ticTacToeBuilder: ticTacToeBuilder
        )
    }
}
