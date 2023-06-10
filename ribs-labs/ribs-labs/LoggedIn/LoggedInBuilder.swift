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
    /// shared instance는 해당 scope(LoggedIn과 하위 RIB)에서 singleton을 의미합니다.
    /// 이 스트림은 일반적으로 stateful object(상태 저장 객체)처럼 scope가 지정된 singleton입니다
    /// 하지만 다른 대부분의 dependency는 상태를 저장하지 않고, 공유되지 않아야 합니다.
    /// *fileprivate가 아닌 이유는, LoggedIn의 자식에서 접근할 수 있어야하기 때문입니다요*
    var mutableScoreStream: MutableScoreStream {
        shared {
            ScoreStreamImpl()
        }
    }
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
        let interactor = LoggedInInteractor(mutableScoreStream: component.mutableScoreStream)
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
