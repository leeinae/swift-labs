//
//  ViewReactor.swift
//  reactorKit-labs
//
//  Created by Devsisters on 2022/07/08.
//

import Foundation
import ReactorKit

final class ViewReactor: Reactor {
    /// user interaction
    enum Action {
        case follow
        case unfollow
    }

    /// view state
    struct State {
        var isFollowing: Bool
    }

    /// changes view state
    /// class 내부에서 Action - State를 연결하는 역할
    enum Mutation {
        case setFollowing(Bool)
    }

    let initialState: State

    init() {
        self.initialState = State(isFollowing: false)
    }
}

extension ViewReactor {
    /// actionStream to mutationStream (call reduce)
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .follow:
                /// service logic - follow
                return Observable.just(Mutation.setFollowing(true))
            case .unfollow: 
                /// service logic - unfollow
                return Observable.just(Mutation.setFollowing(false))
        }
    }

    /// mutationStream, return to State
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
            case let .setFollowing(isfollowing):
                newState.isFollowing = isfollowing
        }

        return newState
    }
}
