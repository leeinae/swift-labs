//
//  OffGameInteractor.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/08.
//

import RIBs
import RxSwift

protocol OffGameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }

    func set(score: Score)
}

protocol OffGameListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func startTicTacToe()
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {
    weak var router: OffGameRouting?
    weak var listener: OffGameListener?
    private let scoreStream: ScoreStream

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: OffGamePresentable, scoreStream: ScoreStream) {
        self.scoreStream = scoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        /// deactive될 때 dispose 되어 interactor가 활성될 때마다 새롭게 구독할 수 있도록 한다.
        updateScore()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    func startGame() {
        listener?.startTicTacToe()
    }

    private func updateScore() {
        scoreStream.score
            .subscribe { [weak self] score in
                self?.presenter.set(score: score)
            }
            /// interactor가 비활성화되면 자동으로 dispose된다.
            .disposeOnDeactivate(interactor: self)
    }
}
