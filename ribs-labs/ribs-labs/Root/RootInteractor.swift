//
//  RootInteractor.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/03.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    /// LoggedIn RIB을 붙이고, 라우팅한다.
    func routeToLoggedIn(player1Name: String, player2Name: String) -> LoggedInActionableItem

    /// LoggedOut RIB 어쩌구 동일 (VC가 있는 RIB으로의 라우팅)
    func routeToLoggedOut()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
    // 다른 RIBs와 커뮤니케이션하기 위해 interactor가 호출할 수 있는 메소드 정의
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
    weak var router: RootRouting?
    weak var listener: RootListener?

    private let loggedInActionableItemSubject = ReplaySubject<LoggedInActionableItem>.create(bufferSize: 1)

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    // MARK: - LoggedOutListener

    /// Root RIB은 자식 RIB listener interface를 구현
    func didLoginIn(player1Name: String, player2Name: String) {
        let loggedInActionableItem = router?.routeToLoggedIn(player1Name: player1Name, player2Name: player2Name)

        if let loggedInActionableItem = loggedInActionableItem {
            loggedInActionableItemSubject.onNext(loggedInActionableItem)
        }
    }
}

extension RootInteractor: URLHandler {
    func handle(_ url: URL) {
        let launchGameWorkflow = LaunchGameWorkflow(url: url)
        launchGameWorkflow
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }
}

extension RootInteractor: RootActionableItem {
    /// RIB에게 actionable item을 전달하는 메소드 (비동기)
    func waitForLogin() -> Observable<(LoggedInActionableItem, ())> {
        loggedInActionableItemSubject
            .map { loggedInItem -> (LoggedInActionableItem, ()) in
                (loggedInItem, ())
            }
    }
}
