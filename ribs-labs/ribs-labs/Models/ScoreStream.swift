//
//  ScoreStream.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/10.
//

import RxCocoa
import RxSwift

struct Score {
    let player1Score: Int
    let player2Score: Int

    static func equals(lhs: Score, rhs: Score) -> Bool {
        lhs.player1Score == rhs.player1Score && lhs.player2Score == rhs.player2Score
    }
}

/// Read-Only
protocol ScoreStream: AnyObject {
    var score: Observable<Score> { get }
}

/// Mutable-version
protocol MutableScoreStream: ScoreStream {
    func updateScore(withWinner winner: PlayerType)
}

class ScoreStreamImpl: MutableScoreStream {
    private let variable = BehaviorRelay(value: Score(player1Score: 0, player2Score: 0))

    var score: Observable<Score> {
        variable
            .asObservable()
            .distinctUntilChanged { lhs, rhs in
                Score.equals(lhs: lhs, rhs: rhs)
            }
    }

    func updateScore(withWinner winner: PlayerType) {
        let newScore: Score = {
            let currentScore = variable.value

            switch winner {
            case .player1:
                return Score(player1Score: currentScore.player1Score + 1, player2Score: currentScore.player2Score)
            case .player2:
                return Score(player1Score: currentScore.player1Score, player2Score: currentScore.player2Score + 1)
            }
        }()
        variable.accept(newScore)
    }
}
