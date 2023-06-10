//
//  OffGameBuilder.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/08.
//

import RIBs

protocol OffGameDependency: Dependency {
    var player1Name: String { get }
    var player2Name: String { get }
    var scoreStream: ScoreStream { get }
}

/// fileprivate 접근 제한자로 dependency를 선언해 해당 RIB에서만 사용하도록 할 수 있다
/// LoggedIn RIB에서는 자식 RIB에서 사용되길 원해서 fileprivate을 쓰지 않음
final class OffGameComponent: Component<OffGameDependency> {
    fileprivate var player1Name: String {
        dependency.player1Name
    }

    fileprivate var player2Name: String {
        dependency.player2Name
    }

    /// LoggedIn RIB에서와 달리 fileprivate인 이유는, OffGame 하위로 해당 스트림을 토출할 필요가 없어서
    fileprivate var scoreStream: ScoreStream {
        dependency.scoreStream
    }
}

// MARK: - Builder

protocol OffGameBuildable: Buildable {
    func build(withListener listener: OffGameListener) -> OffGameRouting
}

final class OffGameBuilder: Builder<OffGameDependency>, OffGameBuildable {
    override init(dependency: OffGameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OffGameListener) -> OffGameRouting {
        let component = OffGameComponent(dependency: dependency)
        let viewController = OffGameViewController(
            player1Name: component.player1Name,
            player2Name: component.player2Name
        )
        let interactor = OffGameInteractor(
            presenter: viewController,
            scoreStream: component.scoreStream
        )
        interactor.listener = listener
        return OffGameRouter(interactor: interactor, viewController: viewController)
    }
}
