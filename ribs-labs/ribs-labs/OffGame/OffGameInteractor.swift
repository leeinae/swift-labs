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
}

protocol OffGameListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func startGame(with gameBuilder: GameBuildable)
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {
    weak var router: OffGameRouting?
    weak var listener: OffGameListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: OffGamePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        /// deactive될 때 dispose 되어 interactor가 활성될 때마다 새롭게 구독할 수 있도록 한다.
//        updateScore()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    func start(_ game: Game) {
        listener?.startGame(with: game.builder)
    }
}
