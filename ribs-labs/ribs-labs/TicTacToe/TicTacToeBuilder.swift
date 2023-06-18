//
//  TicTacToeBuilder.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/10.
//

import RIBs

protocol TicTacToeDependency: Dependency {
    var player1Name: String { get }
    var player2Name: String { get }
    var mutableScoreStream: MutableScoreStream { get }
}

final class TicTacToeComponent: Component<TicTacToeDependency> {
    fileprivate var player1Name: String {
        dependency.player1Name
    }

    fileprivate var player2Name: String {
        dependency.player2Name
    }

    fileprivate var mutableScoreStream: MutableScoreStream {
        dependency.mutableScoreStream
    }
}

// MARK: - Builder

protocol TicTacToeBuildable: Buildable {
    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting
}

final class TicTacToeBuilder: Builder<TicTacToeDependency>, TicTacToeBuildable {
    override init(dependency: TicTacToeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting {
        let component = TicTacToeComponent(dependency: dependency)
        let viewController = TicTacToeViewController(
            player1Name: component.player1Name,
            player2Name: component.player2Name
        )
        let interactor = TicTacToeInteractor(
            presenter: viewController,
            mutableScoreStream: component.mutableScoreStream
        )
        interactor.listener = listener
        return TicTacToeRouter(interactor: interactor, viewController: viewController)
    }
}
