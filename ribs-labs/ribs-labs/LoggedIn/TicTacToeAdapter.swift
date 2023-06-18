//
//  TicTacToeAdapter.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/18.
//

import RIBs

final class TicTacToeAdapter: Game, GameBuildable, TicTacToeListener {
    let id = "tictactoe"
    let name = "Tic Tac Toe"
    let ticTacToeBuilder: TicTacToeBuilder

    var builder: GameBuildable {
        return self
    }

    weak var gameListener: GameListener?

    init(dependency: TicTacToeDependency) {
        self.ticTacToeBuilder = TicTacToeBuilder(dependency: dependency)
    }

    func build(withListener listener: GameListener) -> ViewableRouting {
        gameListener = listener
        return ticTacToeBuilder.build(withListener: self)
    }

    func ticTacToeDidEnd(with winner: PlayerType?) {
        gameListener?.gameDidEnd(with: winner)
    }
}
