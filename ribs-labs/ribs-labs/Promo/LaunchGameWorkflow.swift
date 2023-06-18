//
//  LaunchGameWorkflow.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/11.
//

import RIBs
import RxSwift

/// 1. 플레이어가 Login하지 않으면, Login 할 때까지 대기 후 Game으로 입장 (Root)
/// 2. Login 상태(Ready)가 되면, observable stream을 방출해 1번 step -> 2번 step으로 이동 (LoggedIn)
class LaunchGameWorkflow: Workflow<RootActionableItem> {
    init(url: URL) {
        super.init()

        let gameID = parseGameID(from: url)

        /// workflow 생성
        onStep { rootItem -> Observable<(LoggedInActionableItem, ())> in
            rootItem.waitForLogin()
        }
        .onStep { (loggedInItem, _) -> Observable<(LoggedInActionableItem, ())> in
            loggedInItem.launchGame(with: gameID)
        }
        .commit()

    }

    private func parseGameID(from url: URL) -> String? {
        let components = URLComponents(string: url.absoluteString)
        let items = components?.queryItems ?? []
        for item in items {
            if item.name == "gameId" {
                return item.value
            }
        }

        return nil
    }
}
