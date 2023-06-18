//
//  RootActionableItem.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/12.
//

import RxSwift

/// 유저의 login을 기다리는 protocol
protocol RootActionableItem: AnyObject {
    /// 리턴으로 방출되는 tuple은 현재 step이 완료된 후에 실행될 수 있는 workflow를 나타낸다.
    /// 첫 번째 value가 emit 될 때까지, workflow는 block될 것이다. 
    func waitForLogin() -> Observable<(LoggedInActionableItem, Void)>
}
