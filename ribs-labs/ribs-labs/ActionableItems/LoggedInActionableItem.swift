//
//  LoggedInActionableItem.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/12.
//

import RxSwift

/// 두 번째 step을 위해 LoggedIn RIBdp 추가되어야하는 actionableItem
/// 완료 후 다음 단계를 거칠 필요가 없으므로 자신을 리턴한다.
protocol LoggedInActionableItem: AnyObject {
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, Void)>
}
