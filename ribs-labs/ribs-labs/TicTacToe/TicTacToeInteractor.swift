//
//  TicTacToeInteractor.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/10.
//

import RIBs
import RxSwift

enum GameConstants {
    static let rowCount = 3
    static let colCount = 3
}

protocol TicTacToeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TicTacToePresentable: Presentable {
    var listener: TicTacToePresentableListener? { get set }

    func setCell(atRow row: Int, col: Int, withPlayerType playerType: PlayerType)
    func announce(winner: PlayerType?, withCompletionHandler handler: @escaping () -> Void)
}

protocol TicTacToeListener: AnyObject {
    func ticTacToeDidEnd(with winner: PlayerType?)
}

final class TicTacToeInteractor: PresentableInteractor<TicTacToePresentable>, TicTacToePresentableListener {
    weak var router: TicTacToeRouting?
    weak var listener: TicTacToeListener?

    private var currentPlayer = PlayerType.player1
    private var board = [[PlayerType?]]()
    private let mutableScoreStream: MutableScoreStream

    init(
        presenter: TicTacToePresentable,
        mutableScoreStream: MutableScoreStream
    ) {
        self.mutableScoreStream = mutableScoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        initBoard()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    private func initBoard() {
        for _ in 0 ..< GameConstants.rowCount {
            board.append([nil, nil, nil])
        }
    }

    private func getAndFlipCurrentPlayer() -> PlayerType {
        let currentPlayer = self.currentPlayer
        self.currentPlayer = currentPlayer == .player1 ? .player2 : .player1
        return currentPlayer
    }

    private func checkWinner() -> PlayerType? {
        // Rows.
        for row in 0 ..< GameConstants.rowCount {
            guard let assumedWinner = board[row][0] else {
                continue
            }
            var winner: PlayerType? = assumedWinner
            for col in 1 ..< GameConstants.colCount {
                if assumedWinner.rawValue != board[row][col]?.rawValue {
                    winner = nil
                    break
                }
            }
            if let winner = winner {
                return winner
            }
        }

        // Cols.
        for col in 0 ..< GameConstants.colCount {
            guard let assumedWinner = board[0][col] else {
                continue
            }
            var winner: PlayerType? = assumedWinner
            for row in 1 ..< GameConstants.rowCount {
                if assumedWinner.rawValue != board[row][col]?.rawValue {
                    winner = nil
                    break
                }
            }
            if let winner = winner {
                return winner
            }
        }

        // Diagonal.
        guard let p11 = board[1][1] else {
            return nil
        }
        if let p00 = board[0][0], let p22 = board[2][2] {
            if p00.rawValue == p11.rawValue, p11.rawValue == p22.rawValue {
                return p11
            }
        }

        if let p02 = board[0][2], let p20 = board[2][0] {
            if p02.rawValue == p11.rawValue, p11.rawValue == p20.rawValue {
                return p11
            }
        }

        return nil
    }

    private func checkEndGame() -> (winner: PlayerType?, didEnd: Bool) {
        let winner = checkWinner()
        if let winner = winner {
            return (winner, true)
        }
        let isDraw = checkDraw()
        if isDraw {
            return (nil, true)
        }

        return (nil, false)
    }

    private func checkDraw() -> Bool {
        for row in 0 ..< GameConstants.rowCount {
            for col in 0 ..< GameConstants.colCount {
                if board[row][col] == nil {
                    return false
                }
            }
        }
        return true
    }
}

extension TicTacToeInteractor: TicTacToeInteractable {
    func placeCurrentPlayerMark(atRow row: Int, col: Int) {
        guard board[row][col] == nil else {
            return
        }

        let currentPlayer = getAndFlipCurrentPlayer()
        board[row][col] = currentPlayer
        presenter.setCell(atRow: row, col: col, withPlayerType: currentPlayer)

        let endGame = checkEndGame()
        if endGame.didEnd {
            if let winner = endGame.winner {
                mutableScoreStream.updateScore(withWinner: winner)
            }

            presenter.announce(winner: endGame.winner) {
                self.listener?.ticTacToeDidEnd(with: endGame.winner)
            }
        }
    }
}
